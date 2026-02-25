# frozen_string_literal: true

module Edi810
  module Segments
    class SDQ < Segment
      segment_id "SDQ"

      element :unit_of_measurement_code, position: 1, type: :string, required: true, min_length: 2, max_length: 2
      element :identification_code_qualifier, position: 2, type: :string, min_length: 1, max_length: 2
      element :identification_code, position: 3, type: :string, min_length: 2, max_length: 80
      element :quantity, position: 4, type: :decimal, min_length: 1, max_length: 15
      element :identification_code2, position: 5, type: :string, min_length: 2, max_length: 80
      element :quantity2, position: 6, type: :decimal, min_length: 1, max_length: 15
      element :identification_code3, position: 7, type: :string, min_length: 2, max_length: 80
      element :quantity3, position: 8, type: :decimal, min_length: 1, max_length: 15
      element :identification_code4, position: 9, type: :string, min_length: 2, max_length: 80
      element :quantity4, position: 10, type: :decimal, min_length: 1, max_length: 15
      element :identification_code5, position: 11, type: :string, min_length: 2, max_length: 80
      element :quantity5, position: 12, type: :decimal, min_length: 1, max_length: 15
      element :identification_code6, position: 13, type: :string, min_length: 2, max_length: 80
      element :quantity6, position: 14, type: :decimal, min_length: 1, max_length: 15
      element :identification_code7, position: 15, type: :string, min_length: 2, max_length: 80
      element :quantity7, position: 16, type: :decimal, min_length: 1, max_length: 15
      element :identification_code8, position: 17, type: :string, min_length: 2, max_length: 80
      element :quantity8, position: 18, type: :decimal, min_length: 1, max_length: 15
      element :identification_code9, position: 19, type: :string, min_length: 2, max_length: 80
      element :quantity9, position: 20, type: :decimal, min_length: 1, max_length: 15
      element :identification_code10, position: 21, type: :string, min_length: 2, max_length: 80
      element :quantity10, position: 22, type: :decimal, min_length: 1, max_length: 15
    end
  end
end
