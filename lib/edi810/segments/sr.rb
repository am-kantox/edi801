# frozen_string_literal: true

module Edi810
  module Segments
    class SR < Segment
      segment_id "SR"

      element :assigned_identification, position: 1, type: :string, min_length: 1, max_length: 20
      element :day_rotation, position: 2, type: :string, min_length: 1, max_length: 7
      element :time, position: 3, type: :time, min_length: 4, max_length: 8
      element :time2, position: 4, type: :time, min_length: 4, max_length: 8
      element :free_form_message_text, position: 5, type: :string, min_length: 1, max_length: 264
      element :unit_price, position: 6, type: :decimal, min_length: 1, max_length: 17
      element :quantity, position: 7, type: :decimal, min_length: 1, max_length: 15
      element :date, position: 8, type: :date, min_length: 8, max_length: 8
      element :date2, position: 9, type: :date, min_length: 8, max_length: 8
      element :product_service_id, position: 10, type: :string, min_length: 1, max_length: 48
      element :product_service_id2, position: 11, type: :string, min_length: 1, max_length: 48
    end
  end
end
