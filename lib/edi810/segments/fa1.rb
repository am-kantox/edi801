# frozen_string_literal: true

module Edi810
  module Segments
    class FA1 < Segment
      segment_id "FA1"

      element :agency_qualifier_code, position: 1, type: :string, required: true, min_length: 2, max_length: 2
      element :service_promotion_allowance_charge_code, position: 2, type: :string, min_length: 4, max_length: 4
      element :allowance_or_charge_indicator, position: 3, type: :string, min_length: 1, max_length: 1
    end
  end
end
