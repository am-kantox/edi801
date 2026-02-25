# frozen_string_literal: true

module Edi810
  module Segments
    class CTP < Segment
      segment_id "CTP"

      element :class_of_trade_code, position: 1, type: :string, min_length: 2, max_length: 2
      element :price_identifier_code, position: 2, type: :string, min_length: 3, max_length: 3
      element :unit_price, position: 3, type: :decimal, min_length: 1, max_length: 17
      element :quantity, position: 4, type: :decimal, min_length: 1, max_length: 15
      element :composite_unit_of_measure, position: 5, type: :string, min_length: 1
      element :price_multiplier_qualifier, position: 6, type: :string, min_length: 3, max_length: 3
      element :multiplier, position: 7, type: :decimal, min_length: 1, max_length: 10
      element :monetary_amount, position: 8, type: :decimal, min_length: 1, max_length: 18
      element :basis_of_unit_price_code, position: 9, type: :string, min_length: 2, max_length: 2
      element :condition_value, position: 10, type: :string, min_length: 1, max_length: 10
      element :multiple_price_quantity, position: 11, type: :integer, min_length: 1, max_length: 2
    end
  end
end
