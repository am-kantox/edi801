# frozen_string_literal: true

module Edi810
  module Loops
    class LMLoop
      attr_accessor :lm, :lqs

      def initialize
        @lqs = []
      end

      def to_h
        h = { lm: lm&.to_h }
        h[:lqs] = lqs.map(&:to_h) unless lqs.empty?
        h
      end

      def segments
        segs = []
        segs << lm if lm
        segs.concat(lqs)
        segs
      end
    end
  end
end
