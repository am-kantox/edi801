# frozen_string_literal: true

module Edi810
  module Segments
    class SLN < Segment
      segment_id "SLN"

      element :assigned_identification, position: 1, type: :string, required: true, min_length: 1, max_length: 20
      element :assigned_identification2, position: 2, type: :string, min_length: 1, max_length: 20
      element :relationship_code, position: 3, type: :string, required: true, min_length: 1, max_length: 1
      element :quantity, position: 4, type: :decimal, min_length: 1, max_length: 15
      element :composite_unit_of_measure, position: 5, type: :string, min_length: 1
      element :unit_price, position: 6, type: :decimal, min_length: 1, max_length: 17
      element :basis_of_unit_price_code, position: 7, type: :string, min_length: 2, max_length: 2
      element :product_service_id_qualifier, position: 8, type: :string, min_length: 2, max_length: 2
      element :product_service_id, position: 9, type: :string, min_length: 1, max_length: 48
      element :product_service_id_qualifier2, position: 10, type: :string, min_length: 2, max_length: 2
      element :product_service_id2, position: 11, type: :string, min_length: 1, max_length: 48
      element :product_service_id_qualifier3, position: 12, type: :string, min_length: 2, max_length: 2
      element :product_service_id3, position: 13, type: :string, min_length: 1, max_length: 48
      element :product_service_id_qualifier4, position: 14, type: :string, min_length: 2, max_length: 2
      element :product_service_id4, position: 15, type: :string, min_length: 1, max_length: 48
      element :product_service_id_qualifier5, position: 16, type: :string, min_length: 2, max_length: 2
      element :product_service_id5, position: 17, type: :string, min_length: 1, max_length: 48
      element :product_service_id_qualifier6, position: 18, type: :string, min_length: 2, max_length: 2
      element :product_service_id6, position: 19, type: :string, min_length: 1, max_length: 48
      element :product_service_id_qualifier7, position: 20, type: :string, min_length: 2, max_length: 2
      element :product_service_id7, position: 21, type: :string, min_length: 1, max_length: 48
      element :product_service_id_qualifier8, position: 22, type: :string, min_length: 2, max_length: 2
      element :product_service_id8, position: 23, type: :string, min_length: 1, max_length: 48
      element :product_service_id_qualifier9, position: 24, type: :string, min_length: 2, max_length: 2
      element :product_service_id9, position: 25, type: :string, min_length: 1, max_length: 48
      element :product_service_id_qualifier10, position: 26, type: :string, min_length: 2, max_length: 2
      element :product_service_id10, position: 27, type: :string, min_length: 1, max_length: 48
    end
  end
end
