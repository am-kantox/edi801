# frozen_string_literal: true

module Edi810
  module Loops
    class IT1Loop
      attr_accessor :it1,
                    :crc, :quantities, :currency, :additional_items,
                    :taxes, :pricing, :period_amounts, :measurements,
                    :pid_loops, :paperwork, :packaging, :physical_details,
                    :terms_of_sale, :references, :yes_no_questions, :contacts,
                    :destination_quantities, :dates, :carriers, :tariffs,
                    :service_schedule,
                    :sac_loops, :sln_loops, :n1_loops, :fa1_loops, :lm_loops

      def initialize
        @quantities              = []
        @additional_items        = []
        @taxes                   = []
        @pricing                 = []
        @period_amounts          = []
        @measurements            = []
        @pid_loops               = []
        @paperwork               = []
        @packaging               = []
        @terms_of_sale           = []
        @references              = []
        @yes_no_questions        = []
        @contacts                = []
        @destination_quantities  = []
        @dates                   = []
        @carriers                = []
        @tariffs                 = []
        @sac_loops               = []
        @sln_loops               = []
        @n1_loops                = []
        @fa1_loops               = []
        @lm_loops                = []
      end

      # Convenience accessors delegating to the IT1 segment
      def line_number
        it1&.assigned_identification
      end

      def quantity
        it1&.quantity_invoiced
      end

      def unit_of_measure
        it1&.unit_of_measurement_code
      end

      def unit_price
        it1&.unit_price
      end

      def product_id
        it1&.product_service_id
      end

      def product_id_qualifier
        it1&.product_service_id_qualifier
      end

      def description
        pid_loops.first&.pid&.description
      end

      def to_h
        h = { it1: it1&.to_h }
        h[:crc]         = crc.to_h if crc
        h[:quantities]  = quantities.map(&:to_h) unless quantities.empty?
        h[:currency]    = currency.to_h if currency
        h[:taxes]       = taxes.map(&:to_h) unless taxes.empty?
        h[:pid_loops]   = pid_loops.map(&:to_h) unless pid_loops.empty?
        h[:references]  = references.map(&:to_h) unless references.empty?
        h[:dates]       = dates.map(&:to_h) unless dates.empty?
        h[:sac_loops]   = sac_loops.map(&:to_h) unless sac_loops.empty?
        h[:sln_loops]   = sln_loops.map(&:to_h) unless sln_loops.empty?
        h[:n1_loops]    = n1_loops.map(&:to_h) unless n1_loops.empty?
        h
      end

      def segments
        segs = []
        segs << it1 if it1
        segs << crc if crc
        segs.concat(quantities)
        segs << currency if currency
        segs.concat(additional_items)
        segs.concat(taxes)
        segs.concat(pricing)
        segs.concat(period_amounts)
        segs.concat(measurements)
        pid_loops.each { |pl| segs.concat(pl.segments) }
        segs.concat(paperwork)
        segs.concat(packaging)
        segs << physical_details if physical_details
        segs.concat(terms_of_sale)
        segs.concat(references)
        segs.concat(yes_no_questions)
        segs.concat(contacts)
        segs.concat(destination_quantities)
        segs.concat(dates)
        segs.concat(carriers)
        segs.concat(tariffs)
        segs << service_schedule if service_schedule
        sac_loops.each { |sl| segs.concat(sl.segments) }
        sln_loops.each { |sl| segs.concat(sl.segments) }
        n1_loops.each  { |nl| segs.concat(nl.segments) }
        fa1_loops.each { |fl| segs.concat(fl.segments) }
        lm_loops.each  { |ll| segs.concat(ll.segments) }
        segs
      end
    end
  end
end
