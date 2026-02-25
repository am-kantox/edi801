# frozen_string_literal: true

module Edi810
  module Segments
    class GE < Segment
      segment_id "GE"

      element :number_of_transaction_sets_included, position: 1, type: :integer, required: true, min_length: 1, max_length: 6
      element :group_control_number, position: 2, type: :integer, required: true, min_length: 1, max_length: 9
    end
  end
end
