# frozen_string_literal: true

module Edi810
  module Segments
    class IT3 < Segment
      segment_id "IT3"

      element :number_of_units_shipped, position: 1, type: :decimal, min_length: 1, max_length: 10
      element :unit_of_measurement_code, position: 2, type: :string, min_length: 2, max_length: 2
      element :shipment_order_status_code, position: 3, type: :string, min_length: 2, max_length: 2
      element :quantity_difference, position: 4, type: :decimal, min_length: 1, max_length: 9
      element :change_reason_code, position: 5, type: :string, min_length: 2, max_length: 2
    end
  end
end
