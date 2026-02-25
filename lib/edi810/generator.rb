# frozen_string_literal: true

module Edi810
  class Generator
    DEFAULT_ELEMENT_SEPARATOR     = "*"
    DEFAULT_SUB_ELEMENT_SEPARATOR = ":"
    DEFAULT_SEGMENT_TERMINATOR    = "~"

    attr_reader :element_separator, :sub_element_separator, :segment_terminator, :line_ending

    def initialize(element_separator: nil, sub_element_separator: nil,
                   segment_terminator: nil, line_ending: "\n")
      @element_separator     = element_separator
      @sub_element_separator = sub_element_separator
      @segment_terminator    = segment_terminator
      @line_ending           = line_ending
    end

    def generate(document)
      es = @element_separator     || document.element_separator     || DEFAULT_ELEMENT_SEPARATOR
      st = @segment_terminator    || document.segment_terminator    || DEFAULT_SEGMENT_TERMINATOR

      segments = document.all_segments.compact

      if segments.empty?
        raise GeneratorError, "Document has no segments to generate"
      end

      lines = segments.map { |seg| seg.to_edi(element_separator: es) + st }
      lines.join(@line_ending)
    end
  end
end
