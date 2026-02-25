# frozen_string_literal: true

module Edi810
  module Segments
    class N2 < Segment
      segment_id "N2"

      element :name, position: 1, type: :string, required: true, min_length: 1, max_length: 60
      element :name2, position: 2, type: :string, min_length: 1, max_length: 60
    end
  end
end
