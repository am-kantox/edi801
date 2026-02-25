# frozen_string_literal: true

module Edi810
  module Segments
    class PKG < Segment
      segment_id "PKG"

      element :item_description_type, position: 1, type: :string, min_length: 1, max_length: 1
      element :packaging_characteristic_code, position: 2, type: :string, min_length: 1, max_length: 5
      element :agency_qualifier_code, position: 3, type: :string, min_length: 2, max_length: 2
      element :packaging_description_code, position: 4, type: :string, min_length: 1, max_length: 7
      element :description, position: 5, type: :string, min_length: 1, max_length: 80
      element :unit_load_option_code, position: 6, type: :string, min_length: 2, max_length: 2
    end
  end
end
