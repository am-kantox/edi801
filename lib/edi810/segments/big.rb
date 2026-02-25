# frozen_string_literal: true

module Edi810
  module Segments
    class BIG < Segment
      segment_id "BIG"

      element :invoice_date, position: 1, type: :date, required: true, min_length: 8, max_length: 8
      element :invoice_number, position: 2, type: :string, required: true, min_length: 1, max_length: 22
      element :purchase_order_date, position: 3, type: :date, min_length: 8, max_length: 8
      element :purchase_order_number, position: 4, type: :string, min_length: 1, max_length: 22
      element :release_number, position: 5, type: :string, min_length: 1, max_length: 30
      element :change_order_sequence_number, position: 6, type: :string, min_length: 1, max_length: 8
      element :transaction_type_code, position: 7, type: :string, min_length: 2, max_length: 2
      element :transaction_set_purpose_code, position: 8, type: :string, min_length: 2, max_length: 2
      element :action_code, position: 9, type: :string, min_length: 1, max_length: 2
      element :invoice_number_original, position: 10, type: :string, min_length: 1, max_length: 22
    end
  end
end
