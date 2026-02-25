# frozen_string_literal: true

module Edi810
  module Segments
    class N3 < Segment
      segment_id "N3"

      element :address_information, position: 1, type: :string, required: true, min_length: 1, max_length: 55
      element :address_information2, position: 2, type: :string, min_length: 1, max_length: 55
    end
  end
end
