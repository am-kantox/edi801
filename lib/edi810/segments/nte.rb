# frozen_string_literal: true

module Edi810
  module Segments
    class NTE < Segment
      segment_id "NTE"

      element :note_reference_code, position: 1, type: :string, min_length: 3, max_length: 3
      element :description, position: 2, type: :string, required: true, min_length: 1, max_length: 80
    end
  end
end
