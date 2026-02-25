# frozen_string_literal: true

module Edi810
  module Segments
    class CUR < Segment
      segment_id "CUR"

      element :entity_identifier_code, position: 1, type: :string, required: true, min_length: 2, max_length: 3
      element :currency_code, position: 2, type: :string, required: true, min_length: 3, max_length: 3
      element :exchange_rate, position: 3, type: :decimal, min_length: 4, max_length: 10
      element :entity_identifier_code2, position: 4, type: :string, min_length: 2, max_length: 3
      element :currency_code2, position: 5, type: :string, min_length: 3, max_length: 3
      element :currency_market_exchange_code, position: 6, type: :string, min_length: 3, max_length: 3
      element :date_time_qualifier, position: 7, type: :string, min_length: 3, max_length: 3
      element :date, position: 8, type: :date, min_length: 8, max_length: 8
      element :time, position: 9, type: :time, min_length: 4, max_length: 8
      element :date_time_qualifier2, position: 10, type: :string, min_length: 3, max_length: 3
      element :date2, position: 11, type: :date, min_length: 8, max_length: 8
      element :time2, position: 12, type: :time, min_length: 4, max_length: 8
    end
  end
end
