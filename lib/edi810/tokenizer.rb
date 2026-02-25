# frozen_string_literal: true

module Edi810
  class Tokenizer
    attr_reader :element_separator, :sub_element_separator, :segment_terminator

    SegmentToken = Struct.new(:id, :elements, keyword_init: true)

    def initialize(input)
      @input = input.gsub(/\r\n?/, "\n").strip
      detect_delimiters
    end

    def tokenize
      raw_segments = @input.split(segment_terminator)
      raw_segments.map(&:strip).reject(&:empty?).map do |seg|
        elements = seg.split(element_separator, -1)
        SegmentToken.new(id: elements[0].strip.upcase, elements: elements)
      end
    end

    private

    def detect_delimiters
      input = @input.lstrip

      unless input[0, 3] == "ISA"
        raise TokenizeError, "EDI input must start with an ISA segment"
      end

      if input.length < 105
        raise TokenizeError, "ISA segment is too short (expected at least 105 characters, got #{input.length})"
      end

      @element_separator = input[3]

      # Position 104 = ISA16 (sub-element/component separator)
      # Position 105 = segment terminator (may be ~, newline, or absent)
      raw_sub  = input[104]
      raw_term = input[105]

      # Determine segment terminator.
      # If position 105 holds a printable, non-whitespace character, use it.
      # Otherwise fall back to newline.
      @segment_terminator = if raw_term && raw_term !~ /\s/
                              raw_term
                            else
                              "\n"
                            end

      # Determine sub-element separator.
      # If position 104 holds a printable, non-whitespace character, use it.
      # Otherwise try to derive from ISA element splitting; default to ":".
      if raw_sub && raw_sub !~ /\s/
        @sub_element_separator = raw_sub
      else
        isa_elements = input[4..].split(@element_separator, 17)
        if isa_elements.length >= 16
          tail = isa_elements[15].to_s
          @sub_element_separator = tail[0] if tail[0] && tail[0] !~ /\s/
        end
        @sub_element_separator ||= ":"
      end

      validate_delimiters
    end

    def validate_delimiters
      # When the terminator is a newline it cannot collide with printable
      # element/sub-element separators, so skip the collision check.
      return if @segment_terminator == "\n"

      delims = [@element_separator, @sub_element_separator, @segment_terminator]
      if delims.uniq.length != delims.length
        raise TokenizeError,
              "Delimiter collision detected: element=#{@element_separator.inspect}, " \
              "sub_element=#{@sub_element_separator.inspect}, " \
              "segment=#{@segment_terminator.inspect}"
      end
    end
  end
end
