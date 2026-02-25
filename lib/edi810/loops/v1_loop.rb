# frozen_string_literal: true

module Edi810
  module Loops
    class V1Loop
      attr_accessor :v1, :ports, :dates

      def initialize
        @ports = []
        @dates = []
      end

      def to_h
        h = { v1: v1&.to_h }
        h[:ports] = ports.map(&:to_h) unless ports.empty?
        h[:dates] = dates.map(&:to_h) unless dates.empty?
        h
      end

      def segments
        segs = []
        segs << v1 if v1
        segs.concat(ports)
        segs.concat(dates)
        segs
      end
    end
  end
end
