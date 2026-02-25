# frozen_string_literal: true

module Edi810
  module Segments
    class CTT < Segment
      segment_id "CTT"

      element :number_of_line_items, position: 1, type: :integer, required: true, min_length: 1, max_length: 6
      element :hash_total, position: 2, type: :decimal, min_length: 1, max_length: 10
      element :weight, position: 3, type: :decimal, min_length: 1, max_length: 10
      element :unit_of_measurement_code, position: 4, type: :string, min_length: 2, max_length: 2
      element :volume, position: 5, type: :decimal, min_length: 1, max_length: 8
      element :unit_of_measurement_code2, position: 6, type: :string, min_length: 2, max_length: 2
      element :description, position: 7, type: :string, min_length: 1, max_length: 80
    end
  end
end
