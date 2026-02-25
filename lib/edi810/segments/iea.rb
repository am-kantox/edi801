# frozen_string_literal: true

module Edi810
  module Segments
    class IEA < Segment
      segment_id "IEA"

      element :number_of_included_functional_groups, position: 1, type: :integer, required: true, min_length: 1, max_length: 5
      element :interchange_control_number, position: 2, type: :string, required: true, min_length: 9, max_length: 9
    end
  end
end
