# frozen_string_literal: true

require "date"
require "bigdecimal"

require_relative "edi810/version"
require_relative "edi810/errors"

module Edi810
  class << self
    def segment_registry
      @segment_registry ||= {}
    end

    def register_segment(id, klass)
      segment_registry[id] = klass
    end

    def segment_class_for(id)
      segment_registry[id]
    end

    def parse(input)
      Parser.new(input).parse
    end

    def parse_file(path)
      parse(File.read(path))
    end

    def validate(document)
      Validator.new(document).validate
    end

    def generate(document, **options)
      Generator.new(**options).generate(document)
    end
  end
end

require_relative "edi810/segment"
require_relative "edi810/tokenizer"

Dir[File.join(__dir__, "edi810", "segments", "*.rb")].sort.each { |f| require f }
Dir[File.join(__dir__, "edi810", "loops", "*.rb")].sort.each { |f| require f }

require_relative "edi810/document"
require_relative "edi810/parser"
require_relative "edi810/validator"
require_relative "edi810/generator"
