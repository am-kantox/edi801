# frozen_string_literal: true

module Edi810
  module Segments
    class MTX < Segment
      segment_id "MTX"

      element :note_reference_code, position: 1, type: :string, min_length: 3, max_length: 3
      element :text, position: 2, type: :string, min_length: 1, max_length: 4096
      element :text_format, position: 3, type: :string, min_length: 2, max_length: 2
      element :communication_number_qualifier, position: 4, type: :string, min_length: 2, max_length: 2
    end
  end
end
