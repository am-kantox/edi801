# frozen_string_literal: true

module Edi810
  module Segments
    class YNQ < Segment
      segment_id "YNQ"

      element :condition_indicator, position: 1, type: :string, min_length: 1, max_length: 1
      element :yes_no_condition_response_code, position: 2, type: :string, min_length: 1, max_length: 1
      element :date_time_period_format_qualifier, position: 3, type: :string, min_length: 2, max_length: 3
      element :date_time_period, position: 4, type: :string, min_length: 1, max_length: 35
      element :free_form_message_text, position: 5, type: :string, min_length: 1, max_length: 264
      element :free_form_message_text2, position: 6, type: :string, min_length: 1, max_length: 264
      element :free_form_message_text3, position: 7, type: :string, min_length: 1, max_length: 264
      element :code_list_qualifier_code, position: 8, type: :string, min_length: 1, max_length: 3
      element :industry_code, position: 9, type: :string, min_length: 1, max_length: 30
      element :free_form_message_text4, position: 10, type: :string, min_length: 1, max_length: 264
    end
  end
end
