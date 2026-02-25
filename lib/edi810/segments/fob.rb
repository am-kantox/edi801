# frozen_string_literal: true

module Edi810
  module Segments
    class FOB < Segment
      segment_id "FOB"

      element :shipment_method_of_payment, position: 1, type: :string, required: true, min_length: 2, max_length: 2
      element :location_qualifier, position: 2, type: :string, min_length: 1, max_length: 2
      element :description, position: 3, type: :string, min_length: 1, max_length: 80
      element :transportation_terms_qualifier_code, position: 4, type: :string, min_length: 2, max_length: 2
      element :transportation_terms_code, position: 5, type: :string, min_length: 3, max_length: 3
      element :location_qualifier2, position: 6, type: :string, min_length: 1, max_length: 2
      element :description2, position: 7, type: :string, min_length: 1, max_length: 80
      element :risk_of_loss_code, position: 8, type: :string, min_length: 2, max_length: 2
      element :description3, position: 9, type: :string, min_length: 1, max_length: 80
    end
  end
end
