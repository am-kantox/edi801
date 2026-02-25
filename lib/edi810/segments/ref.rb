# frozen_string_literal: true

module Edi810
  module Segments
    class REF < Segment
      segment_id "REF"

      element :reference_identification_qualifier, position: 1, type: :string, required: true, min_length: 2, max_length: 3
      element :reference_identification, position: 2, type: :string, min_length: 1, max_length: 50
      element :description, position: 3, type: :string, min_length: 1, max_length: 80
      element :reference_identifier, position: 4, type: :string, min_length: 1
    end
  end
end
