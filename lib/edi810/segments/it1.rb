# frozen_string_literal: true

module Edi810
  module Segments
    class IT1 < Segment
      segment_id "IT1"

      element :assigned_identification, position: 1, type: :string, min_length: 1, max_length: 20
      element :quantity_invoiced, position: 2, type: :decimal, min_length: 1, max_length: 10
      element :unit_of_measurement_code, position: 3, type: :string, min_length: 2, max_length: 2
      element :unit_price, position: 4, type: :decimal, min_length: 1, max_length: 17
      element :basis_of_unit_price_code, position: 5, type: :string, min_length: 2, max_length: 2
      element :product_service_id_qualifier, position: 6, type: :string, min_length: 2, max_length: 2
      element :product_service_id, position: 7, type: :string, min_length: 1, max_length: 48
      element :product_service_id_qualifier2, position: 8, type: :string, min_length: 2, max_length: 2
      element :product_service_id2, position: 9, type: :string, min_length: 1, max_length: 48
      element :product_service_id_qualifier3, position: 10, type: :string, min_length: 2, max_length: 2
      element :product_service_id3, position: 11, type: :string, min_length: 1, max_length: 48
      element :product_service_id_qualifier4, position: 12, type: :string, min_length: 2, max_length: 2
      element :product_service_id4, position: 13, type: :string, min_length: 1, max_length: 48
      element :product_service_id_qualifier5, position: 14, type: :string, min_length: 2, max_length: 2
      element :product_service_id5, position: 15, type: :string, min_length: 1, max_length: 48
      element :product_service_id_qualifier6, position: 16, type: :string, min_length: 2, max_length: 2
      element :product_service_id6, position: 17, type: :string, min_length: 1, max_length: 48
      element :product_service_id_qualifier7, position: 18, type: :string, min_length: 2, max_length: 2
      element :product_service_id7, position: 19, type: :string, min_length: 1, max_length: 48
      element :product_service_id_qualifier8, position: 20, type: :string, min_length: 2, max_length: 2
      element :product_service_id8, position: 21, type: :string, min_length: 1, max_length: 48
      element :product_service_id_qualifier9, position: 22, type: :string, min_length: 2, max_length: 2
      element :product_service_id9, position: 23, type: :string, min_length: 1, max_length: 48
      element :product_service_id_qualifier10, position: 24, type: :string, min_length: 2, max_length: 2
      element :product_service_id10, position: 25, type: :string, min_length: 1, max_length: 48
    end
  end
end
