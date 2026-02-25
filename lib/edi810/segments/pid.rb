# frozen_string_literal: true

module Edi810
  module Segments
    class PID < Segment
      segment_id "PID"

      element :item_description_type, position: 1, type: :string, required: true, min_length: 1, max_length: 1
      element :product_process_characteristic_code, position: 2, type: :string, min_length: 2, max_length: 3
      element :agency_qualifier_code, position: 3, type: :string, min_length: 2, max_length: 2
      element :product_description_code, position: 4, type: :string, min_length: 1, max_length: 12
      element :description, position: 5, type: :string, min_length: 1, max_length: 80
      element :surface_layer_position_code, position: 6, type: :string, min_length: 2, max_length: 2
      element :source_subqualifier, position: 7, type: :string, min_length: 1, max_length: 15
      element :yes_no_condition_response_code, position: 8, type: :string, min_length: 1, max_length: 1
      element :language_code, position: 9, type: :string, min_length: 2, max_length: 3
    end
  end
end
