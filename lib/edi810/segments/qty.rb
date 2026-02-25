# frozen_string_literal: true

module Edi810
  module Segments
    class QTY < Segment
      segment_id "QTY"

      element :quantity_qualifier, position: 1, type: :string, required: true, min_length: 2, max_length: 2
      element :quantity, position: 2, type: :decimal, min_length: 1, max_length: 15
      element :composite_unit_of_measure, position: 3, type: :string, min_length: 1
      element :free_form_information, position: 4, type: :string, min_length: 1, max_length: 30
    end
  end
end
