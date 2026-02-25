# frozen_string_literal: true

module Edi810
  module Loops
    class N9Loop
      attr_accessor :n9, :messages

      def initialize
        @messages = []
      end

      def to_h
        h = { n9: n9&.to_h }
        h[:messages] = messages.map(&:to_h) unless messages.empty?
        h
      end

      def segments
        segs = []
        segs << n9 if n9
        segs.concat(messages)
        segs
      end
    end
  end
end
