# frozen_string_literal: true

module Edi810
  module Loops
    class SLNLoop
      attr_accessor :sln, :dates, :references, :descriptions, :sac_loops

      def initialize
        @dates        = []
        @references   = []
        @descriptions = []
        @sac_loops    = []
      end

      def to_h
        h = { sln: sln&.to_h }
        h[:dates]        = dates.map(&:to_h) unless dates.empty?
        h[:references]   = references.map(&:to_h) unless references.empty?
        h[:descriptions] = descriptions.map(&:to_h) unless descriptions.empty?
        h[:sac_loops]    = sac_loops.map(&:to_h) unless sac_loops.empty?
        h
      end

      def segments
        segs = []
        segs << sln if sln
        segs.concat(dates)
        segs.concat(references)
        segs.concat(descriptions)
        sac_loops.each { |sl| segs.concat(sl.segments) }
        segs
      end
    end
  end
end
