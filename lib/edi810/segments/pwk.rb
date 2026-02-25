# frozen_string_literal: true

module Edi810
  module Segments
    class PWK < Segment
      segment_id "PWK"

      element :report_type_code, position: 1, type: :string, required: true, min_length: 2, max_length: 2
      element :report_transmission_code, position: 2, type: :string, min_length: 1, max_length: 2
      element :report_copies_needed, position: 3, type: :integer, min_length: 1, max_length: 2
      element :entity_identifier_code, position: 4, type: :string, min_length: 2, max_length: 3
      element :identification_code_qualifier, position: 5, type: :string, min_length: 1, max_length: 2
      element :identification_code, position: 6, type: :string, min_length: 2, max_length: 80
      element :description, position: 7, type: :string, min_length: 1, max_length: 80
      element :actions_indicated, position: 8, type: :string, min_length: 2, max_length: 2
      element :request_category_code, position: 9, type: :string, min_length: 1, max_length: 2
    end
  end
end
