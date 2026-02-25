# frozen_string_literal: true

module Edi810
  module Loops
    class N1Loop
      attr_accessor :n1, :n2s, :n3s, :n4, :references, :contacts, :dmg,
                    :terms_of_sale, :dates, :fob,
                    :descriptions, :measurements, :paperwork, :packaging

      def initialize
        @n2s          = []
        @n3s          = []
        @references   = []
        @contacts     = []
        @terms_of_sale = []
        @dates        = []
        @descriptions = []
        @measurements = []
        @paperwork    = []
        @packaging    = []
      end

      def entity_code
        n1&.entity_identifier_code
      end

      def name
        n1&.name
      end

      def address_lines
        n3s.map(&:address_information).compact
      end

      def city
        n4&.city_name
      end

      def state
        n4&.state_or_province_code
      end

      def postal_code
        n4&.postal_code
      end

      def country
        n4&.country_code
      end

      def to_h
        h = { n1: n1&.to_h }
        h[:n2s]          = n2s.map(&:to_h) unless n2s.empty?
        h[:n3s]          = n3s.map(&:to_h) unless n3s.empty?
        h[:n4]           = n4.to_h if n4
        h[:references]   = references.map(&:to_h) unless references.empty?
        h[:contacts]     = contacts.map(&:to_h) unless contacts.empty?
        h[:dmg]          = dmg.to_h if dmg
        h
      end

      def segments
        segs = []
        segs << n1 if n1
        segs.concat(n2s)
        segs.concat(n3s)
        segs << n4 if n4
        segs.concat(references)
        segs.concat(contacts)
        segs << dmg if dmg
        segs.concat(terms_of_sale)
        segs.concat(dates)
        segs << fob if fob
        segs.concat(descriptions)
        segs.concat(measurements)
        segs.concat(paperwork)
        segs.concat(packaging)
        segs
      end
    end
  end
end
