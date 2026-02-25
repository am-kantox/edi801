# frozen_string_literal: true

module Edi810
  module Segments
    class L7 < Segment
      segment_id "L7"

      element :lading_line_item_number, position: 1, type: :integer, min_length: 1, max_length: 3
      element :tariff_agency_code, position: 2, type: :string, min_length: 1, max_length: 4
      element :tariff_number, position: 3, type: :string, min_length: 1, max_length: 7
      element :tariff_section, position: 4, type: :string, min_length: 1, max_length: 2
      element :tariff_item_number, position: 5, type: :string, min_length: 1, max_length: 16
      element :tariff_item_part, position: 6, type: :integer, min_length: 1, max_length: 2
      element :freight_class_code, position: 7, type: :string, min_length: 2, max_length: 5
      element :tariff_supplement_identifier, position: 8, type: :string, min_length: 1, max_length: 4
      element :ex_parte, position: 9, type: :string, min_length: 1, max_length: 1
      element :date, position: 10, type: :date, min_length: 8, max_length: 8
      element :rate_basis_number, position: 11, type: :string, min_length: 1, max_length: 6
      element :tariff_column, position: 12, type: :string, min_length: 1, max_length: 2
      element :tariff_distance, position: 13, type: :integer, min_length: 1, max_length: 5
      element :distance_qualifier, position: 14, type: :string, min_length: 1, max_length: 1
      element :city_name, position: 15, type: :string, min_length: 2, max_length: 30
      element :state_or_province_code, position: 16, type: :string, min_length: 2, max_length: 2
    end
  end
end
