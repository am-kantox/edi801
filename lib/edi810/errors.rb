# frozen_string_literal: true

module Edi810
  class Error < StandardError; end

  class ParseError < Error; end

  class TokenizeError < Error; end

  class ValidationError < Error
    attr_reader :segment_id, :element_name, :code

    def initialize(message, segment_id: nil, element_name: nil, code: nil)
      @segment_id   = segment_id
      @element_name = element_name
      @code         = code
      super(message)
    end
  end

  class GeneratorError < Error; end
end
