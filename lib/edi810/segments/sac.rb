# frozen_string_literal: true

module Edi810
  module Segments
    class SAC < Segment
      segment_id "SAC"

      element :allowance_or_charge_indicator, position: 1, type: :string, required: true, min_length: 1, max_length: 1
      element :service_promotion_allowance_charge_code, position: 2, type: :string, min_length: 4, max_length: 4
      element :agency_qualifier_code, position: 3, type: :string, min_length: 2, max_length: 2
      element :agency_service_promotion_allowance_charge_code, position: 4, type: :string, min_length: 1, max_length: 10
      element :amount, position: 5, type: :decimal, min_length: 1, max_length: 15
      element :allowance_charge_percent_qualifier, position: 6, type: :string, min_length: 1, max_length: 1
      element :percent, position: 7, type: :decimal, min_length: 1, max_length: 6
      element :rate, position: 8, type: :decimal, min_length: 1, max_length: 9
      element :unit_of_measurement_code, position: 9, type: :string, min_length: 2, max_length: 2
      element :quantity, position: 10, type: :decimal, min_length: 1, max_length: 15
      element :quantity2, position: 11, type: :decimal, min_length: 1, max_length: 15
      element :allowance_charge_method_of_handling_code, position: 12, type: :string, min_length: 2, max_length: 2
      element :reference_identification, position: 13, type: :string, min_length: 1, max_length: 50
      element :option_number, position: 14, type: :string, min_length: 1, max_length: 20
      element :description, position: 15, type: :string, min_length: 1, max_length: 80
      element :language_code, position: 16, type: :string, min_length: 2, max_length: 3
    end
  end
end
