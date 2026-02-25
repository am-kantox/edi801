# frozen_string_literal: true

module Edi810
  module Segments
    class FA2 < Segment
      segment_id "FA2"

      element :breakdown_structure_detail_code, position: 1, type: :string, required: true, min_length: 2, max_length: 2
      element :financial_information_code, position: 2, type: :string, required: true, min_length: 1, max_length: 80
    end
  end
end
