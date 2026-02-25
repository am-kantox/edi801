# frozen_string_literal: true

module Edi810
  module Segments
    class LM < Segment
      segment_id "LM"

      element :agency_qualifier_code, position: 1, type: :string, required: true, min_length: 2, max_length: 2
      element :source_subqualifier, position: 2, type: :string, min_length: 1, max_length: 15
    end
  end
end
