# frozen_string_literal: true

module Edi810
  module Segments
    class SE < Segment
      segment_id "SE"

      element :number_of_included_segments, position: 1, type: :integer, required: true, min_length: 1, max_length: 10
      element :transaction_set_control_number, position: 2, type: :string, required: true, min_length: 4, max_length: 9
    end
  end
end
