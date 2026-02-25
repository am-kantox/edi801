# frozen_string_literal: true

module Edi810
  module Segments
    class CRC < Segment
      segment_id "CRC"

      element :code_category, position: 1, type: :string, required: true, min_length: 2, max_length: 2
      element :yes_no_condition_response_code, position: 2, type: :string, required: true, min_length: 1, max_length: 1
      element :condition_indicator, position: 3, type: :string, required: true, min_length: 2, max_length: 3
      element :condition_indicator2, position: 4, type: :string, min_length: 2, max_length: 3
      element :condition_indicator3, position: 5, type: :string, min_length: 2, max_length: 3
      element :condition_indicator4, position: 6, type: :string, min_length: 2, max_length: 3
      element :condition_indicator5, position: 7, type: :string, min_length: 2, max_length: 3
    end
  end
end
