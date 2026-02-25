# frozen_string_literal: true

module Edi810
  module Segments
    class DMG < Segment
      segment_id "DMG"

      element :date_time_period_format_qualifier, position: 1, type: :string, min_length: 2, max_length: 3
      element :date_time_period, position: 2, type: :string, min_length: 1, max_length: 35
      element :gender_code, position: 3, type: :string, min_length: 1, max_length: 1
      element :marital_status_code, position: 4, type: :string, min_length: 1, max_length: 1
      element :composite_race_ethnicity, position: 5, type: :string, min_length: 1
      element :citizenship_status_code, position: 6, type: :string, min_length: 1, max_length: 2
      element :country_code, position: 7, type: :string, min_length: 2, max_length: 3
      element :basis_of_verification_code, position: 8, type: :string, min_length: 1, max_length: 2
      element :quantity, position: 9, type: :decimal, min_length: 1, max_length: 15
      element :code_list_qualifier_code, position: 10, type: :string, min_length: 1, max_length: 3
      element :industry_code, position: 11, type: :string, min_length: 1, max_length: 30
    end
  end
end
