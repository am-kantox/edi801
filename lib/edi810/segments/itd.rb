# frozen_string_literal: true

module Edi810
  module Segments
    class ITD < Segment
      segment_id "ITD"

      element :terms_type_code, position: 1, type: :string, min_length: 2, max_length: 2
      element :terms_basis_date_code, position: 2, type: :string, min_length: 1, max_length: 2
      element :terms_discount_percent, position: 3, type: :decimal, min_length: 1, max_length: 6
      element :terms_discount_due_date, position: 4, type: :date, min_length: 8, max_length: 8
      element :terms_discount_days_due, position: 5, type: :integer, min_length: 1, max_length: 3
      element :terms_net_due_date, position: 6, type: :date, min_length: 8, max_length: 8
      element :terms_net_days, position: 7, type: :integer, min_length: 1, max_length: 3
      element :terms_discount_amount, position: 8, type: :decimal, min_length: 1, max_length: 10
      element :terms_deferred_due_date, position: 9, type: :date, min_length: 8, max_length: 8
      element :deferred_amount_due, position: 10, type: :decimal, min_length: 1, max_length: 10
      element :percent_of_invoice_payable, position: 11, type: :decimal, min_length: 1, max_length: 5
      element :description, position: 12, type: :string, min_length: 1, max_length: 80
      element :day_of_month, position: 13, type: :integer, min_length: 1, max_length: 2
      element :payment_method_code, position: 14, type: :string, min_length: 3, max_length: 3
      element :percent, position: 15, type: :decimal, min_length: 1, max_length: 10
    end
  end
end
