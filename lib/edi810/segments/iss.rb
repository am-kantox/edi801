# frozen_string_literal: true

module Edi810
  module Segments
    class ISS < Segment
      segment_id "ISS"

      element :number_of_units_shipped, position: 1, type: :decimal, min_length: 1, max_length: 10
      element :unit_of_measurement_code, position: 2, type: :string, min_length: 2, max_length: 2
      element :weight, position: 3, type: :decimal, min_length: 1, max_length: 10
      element :unit_of_measurement_code2, position: 4, type: :string, min_length: 2, max_length: 2
      element :volume, position: 5, type: :decimal, min_length: 1, max_length: 8
      element :unit_of_measurement_code3, position: 6, type: :string, min_length: 2, max_length: 2
      element :quantity, position: 7, type: :decimal, min_length: 1, max_length: 15
      element :weight2, position: 8, type: :decimal, min_length: 1, max_length: 10
    end
  end
end
