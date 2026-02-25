# frozen_string_literal: true

module Edi810
  module Segments
    class TDS < Segment
      segment_id "TDS"

      element :total_invoice_amount, position: 1, type: :decimal, required: true, min_length: 1, max_length: 15
      element :amount_subject_to_terms_discount, position: 2, type: :decimal, min_length: 1, max_length: 15
      element :discounted_amount_due, position: 3, type: :decimal, min_length: 1, max_length: 15
      element :terms_discount_amount, position: 4, type: :decimal, min_length: 1, max_length: 15
    end
  end
end
