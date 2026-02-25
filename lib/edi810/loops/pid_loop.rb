# frozen_string_literal: true

module Edi810
  module Loops
    class PIDLoop
      attr_accessor :pid, :measurements

      def initialize
        @measurements = []
      end

      def to_h
        h = { pid: pid&.to_h }
        h[:measurements] = measurements.map(&:to_h) unless measurements.empty?
        h
      end

      def segments
        segs = []
        segs << pid if pid
        segs.concat(measurements)
        segs
      end
    end
  end
end
