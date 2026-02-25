# frozen_string_literal: true

module Edi810
  module Segments
    class TXI < Segment
      segment_id "TXI"

      element :tax_type_code, position: 1, type: :string, required: true, min_length: 2, max_length: 2
      element :monetary_amount, position: 2, type: :decimal, min_length: 1, max_length: 18
      element :percent, position: 3, type: :decimal, min_length: 1, max_length: 10
      element :tax_jurisdiction_code_qualifier, position: 4, type: :string, min_length: 2, max_length: 2
      element :tax_jurisdiction_code, position: 5, type: :string, min_length: 1, max_length: 10
      element :tax_exempt_code, position: 6, type: :string, min_length: 1, max_length: 1
      element :relationship_code, position: 7, type: :string, min_length: 1, max_length: 1
      element :dollar_basis_for_percent, position: 8, type: :decimal, min_length: 1, max_length: 9
      element :tax_identification_number, position: 9, type: :string, min_length: 1, max_length: 20
      element :assigned_identification, position: 10, type: :string, min_length: 1, max_length: 20
    end
  end
end
