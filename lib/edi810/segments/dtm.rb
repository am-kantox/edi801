# frozen_string_literal: true

module Edi810
  module Segments
    class DTM < Segment
      segment_id "DTM"

      element :date_time_qualifier, position: 1, type: :string, required: true, min_length: 3, max_length: 3
      element :date, position: 2, type: :date, min_length: 8, max_length: 8
      element :time, position: 3, type: :time, min_length: 4, max_length: 8
      element :time_code, position: 4, type: :string, min_length: 2, max_length: 2
      element :date_time_period_format_qualifier, position: 5, type: :string, min_length: 2, max_length: 3
      element :date_time_period, position: 6, type: :string, min_length: 1, max_length: 35
    end
  end
end
