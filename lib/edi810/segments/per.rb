# frozen_string_literal: true

module Edi810
  module Segments
    class PER < Segment
      segment_id "PER"

      element :contact_function_code, position: 1, type: :string, required: true, min_length: 2, max_length: 2
      element :name, position: 2, type: :string, min_length: 1, max_length: 60
      element :communication_number_qualifier, position: 3, type: :string, min_length: 2, max_length: 2
      element :communication_number, position: 4, type: :string, min_length: 1, max_length: 256
      element :communication_number_qualifier2, position: 5, type: :string, min_length: 2, max_length: 2
      element :communication_number2, position: 6, type: :string, min_length: 1, max_length: 256
      element :communication_number_qualifier3, position: 7, type: :string, min_length: 2, max_length: 2
      element :communication_number3, position: 8, type: :string, min_length: 1, max_length: 256
      element :contact_inquiry_reference, position: 9, type: :string, min_length: 1, max_length: 20
    end
  end
end
