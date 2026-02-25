# frozen_string_literal: true

module Edi810
  class Segment
    class << self
      def inherited(subclass)
        super
        subclass.instance_variable_set(:@elements_def, [])
      end

      def segment_id(id = nil)
        if id
          @segment_id = id
          Edi810.register_segment(id, self)
        end
        @segment_id
      end

      def elements_def
        @elements_def ||= []
      end

      def element(name, position:, type: :string, required: false, min_length: nil, max_length: nil)
        elements_def << ElementDef.new(
          name: name,
          position: position,
          type: type,
          required: required,
          min_length: min_length,
          max_length: max_length
        )

        attr_accessor name
      end
    end

    attr_reader :raw_elements

    def initialize(raw_elements = [])
      @raw_elements = raw_elements
      parse_elements(raw_elements) unless raw_elements.empty?
    end

    def segment_id
      self.class.segment_id
    end

    def to_h
      h = {}
      self.class.elements_def.each do |el|
        val = public_send(el.name)
        h[el.name] = val unless val.nil?
      end
      h
    end

    def to_edi(element_separator: "*")
      parts = [segment_id]

      max_pos = self.class.elements_def.select { |el| !public_send(el.name).nil? }
                    .map(&:position)
                    .max || 0

      (1..max_pos).each do |pos|
        el_def = self.class.elements_def.find { |e| e.position == pos }
        if el_def
          parts << format_value(public_send(el_def.name), el_def.type)
        else
          parts << ""
        end
      end

      parts.join(element_separator)
    end

    def ==(other)
      other.is_a?(self.class) && to_h == other.to_h
    end

    private

    def parse_elements(elements)
      self.class.elements_def.each do |el|
        raw = elements[el.position]
        public_send(:"#{el.name}=", coerce(raw, el.type))
      end
    end

    def coerce(value, type)
      return nil if value.nil? || value.to_s.strip.empty?

      case type
      when :string  then value.to_s
      when :integer then value.to_i
      when :decimal then BigDecimal(value.to_s)
      when :date    then parse_date(value.to_s)
      when :time    then value.to_s
      else value.to_s
      end
    end

    def format_value(value, type)
      return "" if value.nil?

      case type
      when :date
        value.is_a?(Date) ? value.strftime("%Y%m%d") : value.to_s
      when :decimal
        if value.is_a?(BigDecimal)
          value == value.to_i ? value.to_i.to_s : value.to_s("F")
        else
          value.to_s
        end
      when :integer
        value.to_i.to_s
      else
        value.to_s
      end
    end

    def parse_date(value)
      case value.length
      when 8 then Date.strptime(value, "%Y%m%d")
      when 6 then Date.strptime(value, "%y%m%d")
      else value
      end
    rescue Date::Error, ArgumentError
      value
    end

    ElementDef = Struct.new(:name, :position, :type, :required, :min_length, :max_length, keyword_init: true)
  end
end
