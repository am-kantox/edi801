# frozen_string_literal: true

module Edi810
  module Segments
    class ISA < Segment
      segment_id "ISA"

      element :authorization_information_qualifier, position: 1, type: :string, required: true, min_length: 2, max_length: 2
      element :authorization_information, position: 2, type: :string, min_length: 10, max_length: 10
      element :security_information_qualifier, position: 3, type: :string, required: true, min_length: 2, max_length: 2
      element :security_information, position: 4, type: :string, min_length: 10, max_length: 10
      element :interchange_id_qualifier_sender, position: 5, type: :string, required: true, min_length: 2, max_length: 2
      element :interchange_sender_id, position: 6, type: :string, required: true, min_length: 15, max_length: 15
      element :interchange_id_qualifier_receiver, position: 7, type: :string, required: true, min_length: 2, max_length: 2
      element :interchange_receiver_id, position: 8, type: :string, required: true, min_length: 15, max_length: 15
      element :interchange_date, position: 9, type: :string, required: true, min_length: 6, max_length: 6
      element :interchange_time, position: 10, type: :time, required: true, min_length: 4, max_length: 4
      element :repetition_separator, position: 11, type: :string, required: true, min_length: 1, max_length: 1
      element :interchange_control_version_number, position: 12, type: :string, required: true, min_length: 5, max_length: 5
      element :interchange_control_number, position: 13, type: :string, required: true, min_length: 9, max_length: 9
      element :acknowledgment_requested, position: 14, type: :string, required: true, min_length: 1, max_length: 1
      element :usage_indicator, position: 15, type: :string, required: true, min_length: 1, max_length: 1
      element :component_element_separator, position: 16, type: :string, required: true, min_length: 1, max_length: 1

      # ISA has fixed-width elements. Override to_edi to pad each element
      # to its specified length so the 106-character structure is preserved.
      def to_edi(element_separator: "*")
        parts = ["ISA"]
        self.class.elements_def.each do |el|
          val = public_send(el.name).to_s
          width = el.min_length
          parts << if width
                     val.ljust(width)[0, width]
                   else
                     val
                   end
        end
        parts.join(element_separator)
      end
    end
  end
end
