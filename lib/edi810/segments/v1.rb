# frozen_string_literal: true

module Edi810
  module Segments
    class V1 < Segment
      segment_id "V1"

      element :vessel_code, position: 1, type: :string, min_length: 1, max_length: 8
      element :vessel_name, position: 2, type: :string, min_length: 2, max_length: 28
      element :country_code, position: 3, type: :string, min_length: 2, max_length: 3
      element :flight_voyage_number, position: 4, type: :string, min_length: 2, max_length: 10
      element :standard_carrier_alpha_code, position: 5, type: :string, min_length: 2, max_length: 4
      element :vessel_requirement_code, position: 6, type: :string, min_length: 1, max_length: 1
      element :vessel_type_code, position: 7, type: :string, min_length: 2, max_length: 2
      element :vessel_code_qualifier, position: 8, type: :string, min_length: 1, max_length: 1
      element :transportation_method_type_code, position: 9, type: :string, min_length: 1, max_length: 2
    end
  end
end
