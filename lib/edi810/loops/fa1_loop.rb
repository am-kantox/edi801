# frozen_string_literal: true

module Edi810
  module Loops
    class FA1Loop
      attr_accessor :fa1, :fa2s

      def initialize
        @fa2s = []
      end

      def to_h
        h = { fa1: fa1&.to_h }
        h[:fa2s] = fa2s.map(&:to_h) unless fa2s.empty?
        h
      end

      def segments
        segs = []
        segs << fa1 if fa1
        segs.concat(fa2s)
        segs
      end
    end
  end
end
