# frozen_string_literal: true

module Edi810
  module Segments
    class MEA < Segment
      segment_id "MEA"

      element :measurement_reference_id_code, position: 1, type: :string, min_length: 2, max_length: 2
      element :measurement_qualifier, position: 2, type: :string, min_length: 1, max_length: 3
      element :measurement_value, position: 3, type: :decimal, min_length: 1, max_length: 20
      element :composite_unit_of_measure, position: 4, type: :string, min_length: 1
      element :range_minimum, position: 5, type: :decimal, min_length: 1, max_length: 20
      element :range_maximum, position: 6, type: :decimal, min_length: 1, max_length: 20
      element :measurement_significance_code, position: 7, type: :string, min_length: 2, max_length: 2
      element :measurement_attribute_code, position: 8, type: :string, min_length: 2, max_length: 2
      element :surface_layer_position_code, position: 9, type: :string, min_length: 2, max_length: 2
      element :measurement_method_or_device, position: 10, type: :string, min_length: 2, max_length: 4
      element :code_list_qualifier_code, position: 11, type: :string, min_length: 1, max_length: 3
      element :industry_code, position: 12, type: :string, min_length: 1, max_length: 30
    end
  end
end
