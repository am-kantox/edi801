# frozen_string_literal: true

module Edi810
  module Segments
    class N1 < Segment
      segment_id "N1"

      element :entity_identifier_code, position: 1, type: :string, required: true, min_length: 2, max_length: 3
      element :name, position: 2, type: :string, min_length: 1, max_length: 60
      element :identification_code_qualifier, position: 3, type: :string, min_length: 1, max_length: 2
      element :identification_code, position: 4, type: :string, min_length: 2, max_length: 80
      element :entity_relationship_code, position: 5, type: :string, min_length: 2, max_length: 2
      element :entity_identifier_code2, position: 6, type: :string, min_length: 2, max_length: 3
    end
  end
end
