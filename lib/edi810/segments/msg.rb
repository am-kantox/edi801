# frozen_string_literal: true

module Edi810
  module Segments
    class MSG < Segment
      segment_id "MSG"

      element :free_form_message_text, position: 1, type: :string, required: true, min_length: 1, max_length: 264
      element :printer_carriage_control_code, position: 2, type: :string, min_length: 2, max_length: 2
      element :number, position: 3, type: :integer, min_length: 1, max_length: 9
    end
  end
end
