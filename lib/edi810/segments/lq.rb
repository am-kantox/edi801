# frozen_string_literal: true

module Edi810
  module Segments
    class LQ < Segment
      segment_id "LQ"

      element :code_list_qualifier_code, position: 1, type: :string, min_length: 1, max_length: 3
      element :industry_code, position: 2, type: :string, min_length: 1, max_length: 30
    end
  end
end
