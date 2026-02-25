# frozen_string_literal: true

module Edi810
  module Segments
    class PAM < Segment
      segment_id "PAM"

      element :quantity_qualifier, position: 1, type: :string, min_length: 2, max_length: 2
      element :quantity, position: 2, type: :decimal, min_length: 1, max_length: 15
      element :composite_unit_of_measure, position: 3, type: :string, min_length: 1
      element :amount_qualifier_code, position: 4, type: :string, min_length: 1, max_length: 3
      element :monetary_amount, position: 5, type: :decimal, min_length: 1, max_length: 18
      element :unit_of_time_period_or_interval, position: 6, type: :string, min_length: 2, max_length: 2
      element :date_time_qualifier, position: 7, type: :string, min_length: 3, max_length: 3
      element :date, position: 8, type: :date, min_length: 8, max_length: 8
      element :time, position: 9, type: :time, min_length: 4, max_length: 8
      element :date_time_qualifier2, position: 10, type: :string, min_length: 3, max_length: 3
      element :date2, position: 11, type: :date, min_length: 8, max_length: 8
      element :time2, position: 12, type: :time, min_length: 4, max_length: 8
      element :percent_qualifier, position: 13, type: :string, min_length: 1, max_length: 2
      element :percent, position: 14, type: :decimal, min_length: 1, max_length: 10
      element :yes_no_condition_response_code, position: 15, type: :string, min_length: 1, max_length: 1
    end
  end
end
