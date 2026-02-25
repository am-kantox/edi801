# frozen_string_literal: true

module Edi810
  module Segments
    class ST < Segment
      segment_id "ST"

      element :transaction_set_identifier_code, position: 1, type: :string, required: true, min_length: 3, max_length: 3
      element :transaction_set_control_number, position: 2, type: :string, required: true, min_length: 4, max_length: 9
      element :implementation_convention_ref, position: 3, type: :string, min_length: 1, max_length: 35
    end
  end
end
