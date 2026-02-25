# frozen_string_literal: true

module Edi810
  class Document
    # Detected delimiters
    attr_accessor :element_separator, :sub_element_separator, :segment_terminator

    # Envelope
    attr_accessor :isa, :gs, :st, :se, :ge, :iea

    # Header
    attr_accessor :big, :notes, :currency, :references, :yes_no_questions, :contacts,
                  :n1_loops, :terms_of_sale, :dates, :fob,
                  :descriptions, :measurements, :paperwork, :packaging,
                  :tariff, :balances, :installment, :period_amounts,
                  :conditions, :texts,
                  :lm_loops, :n9_loops, :v1_loops, :fa1_loops

    # Detail
    attr_accessor :line_items

    # Summary
    attr_accessor :tds, :summary_taxes, :summary_carrier,
                  :summary_sac_loops, :invoice_shipment_summaries, :ctt

    def initialize
      # Header collections
      @notes              = []
      @references         = []
      @yes_no_questions   = []
      @contacts           = []
      @n1_loops           = []
      @terms_of_sale      = []
      @dates              = []
      @descriptions       = []
      @measurements       = []
      @paperwork          = []
      @packaging          = []
      @balances           = []
      @period_amounts     = []
      @conditions         = []
      @texts              = []
      @lm_loops           = []
      @n9_loops           = []
      @v1_loops           = []
      @fa1_loops          = []

      # Detail
      @line_items         = []

      # Summary
      @summary_taxes      = []
      @summary_sac_loops  = []
      @invoice_shipment_summaries = []
    end

    # -- Convenience accessors --

    def invoice_number
      big&.invoice_number
    end

    def invoice_date
      big&.invoice_date
    end

    def purchase_order_number
      big&.purchase_order_number
    end

    def purchase_order_date
      big&.purchase_order_date
    end

    def total_amount
      tds&.total_invoice_amount
    end

    def line_item_count
      line_items.size
    end

    def sender_id
      isa&.interchange_sender_id&.strip
    end

    def receiver_id
      isa&.interchange_receiver_id&.strip
    end

    def transaction_control_number
      st&.transaction_set_control_number
    end

    # Find an N1 loop by entity identifier code (e.g. "BT", "ST", "RE")
    def party(code)
      n1_loops.find { |loop| loop.entity_code == code }
    end

    def bill_to
      party("BT")
    end

    def ship_to
      party("ST")
    end

    def remit_to
      party("RE")
    end

    def to_h
      h = {}
      h[:isa] = isa&.to_h
      h[:gs]  = gs&.to_h
      h[:st]  = st&.to_h
      h[:big] = big&.to_h
      h[:notes]       = notes.map(&:to_h) unless notes.empty?
      h[:references]  = references.map(&:to_h) unless references.empty?
      h[:n1_loops]    = n1_loops.map(&:to_h) unless n1_loops.empty?
      h[:line_items]  = line_items.map(&:to_h) unless line_items.empty?
      h[:tds]         = tds&.to_h
      h[:ctt]         = ctt&.to_h
      h[:se]  = se&.to_h
      h[:ge]  = ge&.to_h
      h[:iea] = iea&.to_h
      h
    end

    # Collect all segments in document order for generation
    def all_segments
      segs = []
      segs << isa if isa
      segs << gs  if gs
      segs << st  if st
      segs << big if big
      segs.concat(notes)
      segs << currency if currency
      segs.concat(references)
      segs.concat(yes_no_questions)
      segs.concat(contacts)
      n1_loops.each { |nl| segs.concat(nl.segments) }
      segs.concat(terms_of_sale)
      segs.concat(dates)
      segs << fob if fob
      segs.concat(descriptions)
      segs.concat(measurements)
      segs.concat(paperwork)
      segs.concat(packaging)
      segs << tariff if tariff
      segs.concat(balances)
      segs << installment if installment
      segs.concat(period_amounts)
      segs.concat(conditions)
      segs.concat(texts)
      lm_loops.each  { |ll| segs.concat(ll.segments) }
      n9_loops.each  { |nl| segs.concat(nl.segments) }
      v1_loops.each  { |vl| segs.concat(vl.segments) }
      fa1_loops.each { |fl| segs.concat(fl.segments) }
      line_items.each { |li| segs.concat(li.segments) }
      segs << tds if tds
      segs.concat(summary_taxes)
      segs << summary_carrier if summary_carrier
      summary_sac_loops.each { |sl| segs.concat(sl.segments) }
      segs.concat(invoice_shipment_summaries)
      segs << ctt if ctt
      segs << se  if se
      segs << ge  if ge
      segs << iea if iea
      segs
    end
  end
end
