# frozen_string_literal: true

module Edi810
  module Segments
    class INC < Segment
      segment_id "INC"

      element :terms_type_code, position: 1, type: :string, required: true, min_length: 2, max_length: 2
      element :composite_unit_of_measure, position: 2, type: :string, required: true, min_length: 1
      element :quantity, position: 3, type: :decimal, min_length: 1, max_length: 15
      element :monetary_amount, position: 4, type: :decimal, min_length: 1, max_length: 18
      element :amount_qualifier_code, position: 5, type: :string, min_length: 1, max_length: 3
    end
  end
end
