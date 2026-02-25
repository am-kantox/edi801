# frozen_string_literal: true

module Edi810
  module Segments
    class N4 < Segment
      segment_id "N4"

      element :city_name, position: 1, type: :string, min_length: 2, max_length: 30
      element :state_or_province_code, position: 2, type: :string, min_length: 2, max_length: 2
      element :postal_code, position: 3, type: :string, min_length: 3, max_length: 15
      element :country_code, position: 4, type: :string, min_length: 2, max_length: 3
      element :location_qualifier, position: 5, type: :string, min_length: 1, max_length: 2
      element :location_identifier, position: 6, type: :string, min_length: 1, max_length: 30
      element :country_subdivision_code, position: 7, type: :string, min_length: 1, max_length: 3
    end
  end
end
