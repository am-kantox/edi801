# frozen_string_literal: true

module Edi810
  module Loops
    class SACLoop
      attr_accessor :sac, :taxes

      def initialize
        @taxes = []
      end

      def to_h
        h = { sac: sac&.to_h }
        h[:taxes] = taxes.map(&:to_h) unless taxes.empty?
        h
      end

      def segments
        segs = []
        segs << sac if sac
        segs.concat(taxes)
        segs
      end
    end
  end
end
