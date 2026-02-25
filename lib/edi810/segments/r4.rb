# frozen_string_literal: true

module Edi810
  module Segments
    class R4 < Segment
      segment_id "R4"

      element :port_or_terminal_function_code, position: 1, type: :string, required: true, min_length: 1, max_length: 1
      element :location_qualifier, position: 2, type: :string, min_length: 1, max_length: 2
      element :location_identifier, position: 3, type: :string, min_length: 1, max_length: 30
      element :port_name, position: 4, type: :string, min_length: 2, max_length: 24
      element :country_code, position: 5, type: :string, min_length: 2, max_length: 3
      element :terminal_name, position: 6, type: :string, min_length: 2, max_length: 30
      element :pier_number, position: 7, type: :string, min_length: 1, max_length: 4
      element :state_or_province_code, position: 8, type: :string, min_length: 2, max_length: 2
    end
  end
end
