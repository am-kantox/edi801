# frozen_string_literal: true

module Edi810
  module Segments
    class BAL < Segment
      segment_id "BAL"

      element :balance_type_code, position: 1, type: :string, required: true, min_length: 2, max_length: 2
      element :amount_qualifier_code, position: 2, type: :string, required: true, min_length: 1, max_length: 3
      element :monetary_amount, position: 3, type: :decimal, required: true, min_length: 1, max_length: 18
    end
  end
end
