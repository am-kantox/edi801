# frozen_string_literal: true

module Edi810
  module Segments
    class GS < Segment
      segment_id "GS"

      element :functional_identifier_code, position: 1, type: :string, required: true, min_length: 2, max_length: 2
      element :application_sender_code, position: 2, type: :string, required: true, min_length: 2, max_length: 15
      element :application_receiver_code, position: 3, type: :string, required: true, min_length: 2, max_length: 15
      element :date, position: 4, type: :date, required: true, min_length: 8, max_length: 8
      element :time, position: 5, type: :time, required: true, min_length: 4, max_length: 8
      element :group_control_number, position: 6, type: :integer, required: true, min_length: 1, max_length: 9
      element :responsible_agency_code, position: 7, type: :string, required: true, min_length: 1, max_length: 2
      element :version_release_industry_code, position: 8, type: :string, required: true, min_length: 1, max_length: 12
    end
  end
end
