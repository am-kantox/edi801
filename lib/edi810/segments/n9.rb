# frozen_string_literal: true

module Edi810
  module Segments
    class N9 < Segment
      segment_id "N9"

      element :reference_identification_qualifier, position: 1, type: :string, required: true, min_length: 2, max_length: 3
      element :reference_identification, position: 2, type: :string, min_length: 1, max_length: 50
      element :free_form_description, position: 3, type: :string, min_length: 1, max_length: 45
      element :date, position: 4, type: :date, min_length: 8, max_length: 8
      element :time, position: 5, type: :time, min_length: 4, max_length: 8
      element :time_code, position: 6, type: :string, min_length: 2, max_length: 2
      element :reference_identifier, position: 7, type: :string, min_length: 1
    end
  end
end
