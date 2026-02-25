# frozen_string_literal: true

module Edi810
  class Validator
    attr_reader :errors

    Result = Struct.new(:valid?, :errors, keyword_init: true)

    def initialize(document)
      @document = document
      @errors   = []
    end

    def validate
      validate_envelope
      validate_header
      validate_detail
      validate_summary
      validate_control_numbers
      validate_segment_count
      validate_ctt_integrity

      Result.new(valid?: @errors.empty?, errors: @errors)
    end

    private

    def add_error(message, segment_id: nil, element_name: nil, code: nil)
      @errors << ValidationError.new(
        message,
        segment_id: segment_id,
        element_name: element_name,
        code: code
      )
    end

    # -- Envelope --

    def validate_envelope
      add_error("Missing ISA segment", segment_id: "ISA", code: :missing_segment) unless @document.isa
      add_error("Missing GS segment",  segment_id: "GS",  code: :missing_segment) unless @document.gs
      add_error("Missing ST segment",  segment_id: "ST",  code: :missing_segment) unless @document.st
      add_error("Missing SE segment",  segment_id: "SE",  code: :missing_segment) unless @document.se
      add_error("Missing GE segment",  segment_id: "GE",  code: :missing_segment) unless @document.ge
      add_error("Missing IEA segment", segment_id: "IEA", code: :missing_segment) unless @document.iea

      validate_required_elements(@document.isa) if @document.isa
      validate_required_elements(@document.gs)  if @document.gs
      validate_required_elements(@document.st)  if @document.st
      validate_required_elements(@document.se)  if @document.se
      validate_required_elements(@document.ge)  if @document.ge
      validate_required_elements(@document.iea) if @document.iea

      if @document.st&.transaction_set_identifier_code != "810"
        add_error(
          "ST01 must be '810', got '#{@document.st&.transaction_set_identifier_code}'",
          segment_id: "ST",
          element_name: :transaction_set_identifier_code,
          code: :invalid_value
        )
      end
    end

    # -- Header --

    def validate_header
      add_error("Missing BIG segment", segment_id: "BIG", code: :missing_segment) unless @document.big
      validate_required_elements(@document.big) if @document.big
    end

    # -- Detail --

    def validate_detail
      @document.line_items.each_with_index do |li, idx|
        validate_required_elements(li.it1) if li.it1
        li.pid_loops.each { |pl| validate_required_elements(pl.pid) if pl.pid }
        li.sac_loops.each { |sl| validate_required_elements(sl.sac) if sl.sac }
      end
    end

    # -- Summary --

    def validate_summary
      add_error("Missing TDS segment", segment_id: "TDS", code: :missing_segment) unless @document.tds
      validate_required_elements(@document.tds) if @document.tds
    end

    # -- Control numbers --

    def validate_control_numbers
      # ST02 must match SE02
      if @document.st && @document.se
        st_num = @document.st.transaction_set_control_number
        se_num = @document.se.transaction_set_control_number
        if st_num != se_num
          add_error(
            "ST02 (#{st_num}) does not match SE02 (#{se_num})",
            segment_id: "SE",
            code: :control_number_mismatch
          )
        end
      end

      # GS06 must match GE02
      if @document.gs && @document.ge
        gs_num = @document.gs.group_control_number
        ge_num = @document.ge.group_control_number
        if gs_num != ge_num
          add_error(
            "GS06 (#{gs_num}) does not match GE02 (#{ge_num})",
            segment_id: "GE",
            code: :control_number_mismatch
          )
        end
      end

      # ISA13 must match IEA02
      if @document.isa && @document.iea
        isa_num = @document.isa.interchange_control_number&.strip
        iea_num = @document.iea.interchange_control_number&.strip
        if isa_num != iea_num
          add_error(
            "ISA13 (#{isa_num}) does not match IEA02 (#{iea_num})",
            segment_id: "IEA",
            code: :control_number_mismatch
          )
        end
      end
    end

    # -- Segment count --

    def validate_segment_count
      return unless @document.se

      # SE01 should equal the count of segments from ST to SE inclusive
      expected = count_transaction_segments
      actual   = @document.se.number_of_included_segments
      return unless actual

      if actual != expected
        add_error(
          "SE01 segment count (#{actual}) does not match actual count (#{expected})",
          segment_id: "SE",
          element_name: :number_of_included_segments,
          code: :segment_count_mismatch
        )
      end
    end

    # -- CTT integrity --

    def validate_ctt_integrity
      return unless @document.ctt

      expected_line_count = @document.line_items.size
      actual_line_count   = @document.ctt.number_of_line_items

      if actual_line_count && actual_line_count != expected_line_count
        add_error(
          "CTT01 line item count (#{actual_line_count}) does not match actual IT1 count (#{expected_line_count})",
          segment_id: "CTT",
          element_name: :number_of_line_items,
          code: :ctt_count_mismatch
        )
      end

      if @document.ctt.hash_total
        computed_hash = @document.line_items.sum { |li| li.it1&.quantity_invoiced.to_f }
        declared_hash = @document.ctt.hash_total.to_f
        unless (computed_hash - declared_hash).abs < 0.001
          add_error(
            "CTT02 hash total (#{declared_hash}) does not match sum of IT102 quantities (#{computed_hash})",
            segment_id: "CTT",
            element_name: :hash_total,
            code: :ctt_hash_mismatch
          )
        end
      end
    end

    # -- Element-level validation --

    def validate_required_elements(segment)
      return unless segment.is_a?(Segment)

      segment.class.elements_def.each do |el|
        next unless el.required

        value = segment.public_send(el.name)
        if value.nil? || (value.respond_to?(:empty?) && value.empty?)
          add_error(
            "#{segment.segment_id}: required element #{el.name} is missing",
            segment_id: segment.segment_id,
            element_name: el.name,
            code: :required_element_missing
          )
        end

        validate_length(segment, el, value) if value
      end
    end

    def validate_length(segment, el, value)
      str = value.is_a?(Date) ? value.strftime("%Y%m%d") : value.to_s
      if el.min_length && str.length < el.min_length
        add_error(
          "#{segment.segment_id}.#{el.name}: value '#{str}' is shorter than minimum length #{el.min_length}",
          segment_id: segment.segment_id,
          element_name: el.name,
          code: :min_length_violation
        )
      end
      if el.max_length && str.length > el.max_length
        add_error(
          "#{segment.segment_id}.#{el.name}: value '#{str}' exceeds maximum length #{el.max_length}",
          segment_id: segment.segment_id,
          element_name: el.name,
          code: :max_length_violation
        )
      end
    end

    def count_transaction_segments
      # Count all segments from ST to SE inclusive
      segs = @document.all_segments
      st_idx = segs.index(@document.st)
      se_idx = segs.index(@document.se)
      return 0 unless st_idx && se_idx

      se_idx - st_idx + 1
    end
  end
end
