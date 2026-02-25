# frozen_string_literal: true

module Edi810
  module Segments
    class PO4 < Segment
      segment_id "PO4"

      element :pack, position: 1, type: :integer, min_length: 1, max_length: 6
      element :size, position: 2, type: :decimal, min_length: 1, max_length: 8
      element :unit_of_measurement_code, position: 3, type: :string, min_length: 2, max_length: 2
      element :packaging_code, position: 4, type: :string, min_length: 3, max_length: 5
      element :weight_qualifier, position: 5, type: :string, min_length: 1, max_length: 2
      element :gross_weight_per_pack, position: 6, type: :decimal, min_length: 1, max_length: 9
      element :unit_of_measurement_code2, position: 7, type: :string, min_length: 2, max_length: 2
      element :gross_volume_per_pack, position: 8, type: :decimal, min_length: 1, max_length: 9
      element :unit_of_measurement_code3, position: 9, type: :string, min_length: 2, max_length: 2
      element :length, position: 10, type: :decimal, min_length: 1, max_length: 8
      element :width, position: 11, type: :decimal, min_length: 1, max_length: 8
      element :height, position: 12, type: :decimal, min_length: 1, max_length: 8
      element :unit_of_measurement_code4, position: 13, type: :string, min_length: 2, max_length: 2
      element :inner_pack, position: 14, type: :integer, min_length: 1, max_length: 6
      element :surface_layer_position_code, position: 15, type: :string, min_length: 2, max_length: 2
      element :assigned_identification, position: 16, type: :string, min_length: 1, max_length: 20
      element :assigned_identification2, position: 17, type: :string, min_length: 1, max_length: 20
      element :number, position: 18, type: :integer, min_length: 1, max_length: 9
    end
  end
end
