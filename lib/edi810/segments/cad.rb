# frozen_string_literal: true

module Edi810
  module Segments
    class CAD < Segment
      segment_id "CAD"

      element :transportation_method_type_code, position: 1, type: :string, min_length: 1, max_length: 2
      element :equipment_initial, position: 2, type: :string, min_length: 1, max_length: 4
      element :equipment_number, position: 3, type: :string, min_length: 1, max_length: 10
      element :standard_carrier_alpha_code, position: 4, type: :string, min_length: 2, max_length: 4
      element :routing, position: 5, type: :string, min_length: 1, max_length: 35
      element :shipment_order_status_code, position: 6, type: :string, min_length: 2, max_length: 2
      element :reference_identification_qualifier, position: 7, type: :string, min_length: 2, max_length: 3
      element :reference_identification, position: 8, type: :string, min_length: 1, max_length: 50
      element :service_level_code, position: 9, type: :string, min_length: 2, max_length: 2
    end
  end
end
