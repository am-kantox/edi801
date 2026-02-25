# frozen_string_literal: true

module Edi810
  class Parser
    N1_LOOP_TRIGGERS    = %w[N2 N3 N4 REF PER DMG].freeze
    IT1_CHILD_IDS       = %w[CRC QTY CUR IT3 TXI CTP PAM MEA PID PWK PKG PO4
                             ITD REF YNQ PER SDQ DTM CAD L7 SR SAC SLN N1 FA1 LM].freeze
    SUMMARY_SEGMENT_IDS = %w[TDS TXI CAD SAC ISS CTT].freeze

    def initialize(input)
      @tokenizer = Tokenizer.new(input)
      @tokens    = @tokenizer.tokenize
      @pos       = 0
      @document  = Document.new
      @document.element_separator     = @tokenizer.element_separator
      @document.sub_element_separator = @tokenizer.sub_element_separator
      @document.segment_terminator    = @tokenizer.segment_terminator
    end

    def parse
      parse_isa
      parse_gs
      parse_st
      parse_header
      parse_detail
      parse_summary
      parse_se
      parse_ge
      parse_iea
      @document
    end

    private

    # -- Token navigation --

    def current_token
      @tokens[@pos]
    end

    def current_id
      current_token&.id
    end

    def advance
      @pos += 1
    end

    def build_segment(token)
      klass = Edi810.segment_class_for(token.id)
      if klass
        klass.new(token.elements)
      else
        # Unknown segment: store as generic
        seg = Segment.new(token.elements)
        seg
      end
    end

    def expect(id)
      unless current_id == id
        raise ParseError, "Expected #{id} segment at position #{@pos}, got #{current_id || 'EOF'}"
      end
    end

    def consume(id)
      expect(id)
      seg = build_segment(current_token)
      advance
      seg
    end

    def consume_if(id)
      return nil unless current_id == id

      seg = build_segment(current_token)
      advance
      seg
    end

    # -- Envelope --

    def parse_isa
      @document.isa = consume("ISA")
    end

    def parse_gs
      @document.gs = consume("GS")
    end

    def parse_st
      @document.st = consume("ST")
    end

    def parse_se
      @document.se = consume("SE")
    end

    def parse_ge
      @document.ge = consume("GE")
    end

    def parse_iea
      @document.iea = consume("IEA")
    end

    # -- Header --

    def parse_header
      @document.big = consume("BIG")

      while current_id && current_id != "IT1" && !SUMMARY_SEGMENT_IDS.include?(current_id) && current_id != "SE"
        case current_id
        when "NTE"  then @document.notes << consume("NTE")
        when "CUR"  then @document.currency = consume("CUR")
        when "REF"  then @document.references << consume("REF")
        when "YNQ"  then @document.yes_no_questions << consume("YNQ")
        when "PER"  then @document.contacts << consume("PER")
        when "N1"   then @document.n1_loops << parse_n1_loop
        when "ITD"  then @document.terms_of_sale << consume("ITD")
        when "DTM"  then @document.dates << consume("DTM")
        when "FOB"  then @document.fob = consume("FOB")
        when "PID"  then @document.descriptions << consume("PID")
        when "MEA"  then @document.measurements << consume("MEA")
        when "PWK"  then @document.paperwork << consume("PWK")
        when "PKG"  then @document.packaging << consume("PKG")
        when "L7"   then @document.tariff = consume("L7")
        when "BAL"  then @document.balances << consume("BAL")
        when "INC"  then @document.installment = consume("INC")
        when "PAM"  then @document.period_amounts << consume("PAM")
        when "CRC"  then @document.conditions << consume("CRC")
        when "MTX"  then @document.texts << consume("MTX")
        when "LM"   then @document.lm_loops << parse_lm_loop
        when "N9"   then @document.n9_loops << parse_n9_loop
        when "V1"   then @document.v1_loops << parse_v1_loop
        when "FA1"  then @document.fa1_loops << parse_fa1_loop
        else
          advance # skip unrecognized header segments
        end
      end
    end

    # -- Detail --

    def parse_detail
      while current_id == "IT1"
        @document.line_items << parse_it1_loop
      end
    end

    # -- Summary --

    def parse_summary
      return unless current_id && current_id != "SE"

      if current_id == "TDS"
        @document.tds = consume("TDS")
      end

      while current_id && current_id != "SE"
        case current_id
        when "TXI" then @document.summary_taxes << consume("TXI")
        when "CAD" then @document.summary_carrier = consume("CAD")
        when "SAC" then @document.summary_sac_loops << parse_sac_loop
        when "ISS" then @document.invoice_shipment_summaries << consume("ISS")
        when "CTT" then @document.ctt = consume("CTT")
        else
          advance
        end
      end
    end

    # -- Loop parsers --

    def parse_n1_loop
      loop = Loops::N1Loop.new
      loop.n1 = consume("N1")

      while current_id && n1_child?(current_id)
        case current_id
        when "N2"  then loop.n2s << consume("N2")
        when "N3"  then loop.n3s << consume("N3")
        when "N4"  then loop.n4 = consume("N4")
        when "REF" then loop.references << consume("REF")
        when "PER" then loop.contacts << consume("PER")
        when "DMG" then loop.dmg = consume("DMG")
        when "ITD" then loop.terms_of_sale << consume("ITD")
        when "DTM" then loop.dates << consume("DTM")
        when "FOB" then loop.fob = consume("FOB")
        when "PID" then loop.descriptions << consume("PID")
        when "MEA" then loop.measurements << consume("MEA")
        when "PWK" then loop.paperwork << consume("PWK")
        when "PKG" then loop.packaging << consume("PKG")
        else
          break
        end
      end

      loop
    end

    def parse_it1_loop
      loop = Loops::IT1Loop.new
      loop.it1 = consume("IT1")

      while current_id && it1_child?(current_id)
        case current_id
        when "CRC" then loop.crc = consume("CRC")
        when "QTY" then loop.quantities << consume("QTY")
        when "CUR" then loop.currency = consume("CUR")
        when "IT3" then loop.additional_items << consume("IT3")
        when "TXI" then loop.taxes << consume("TXI")
        when "CTP" then loop.pricing << consume("CTP")
        when "PAM" then loop.period_amounts << consume("PAM")
        when "MEA" then loop.measurements << consume("MEA")
        when "PID" then loop.pid_loops << parse_pid_loop
        when "PWK" then loop.paperwork << consume("PWK")
        when "PKG" then loop.packaging << consume("PKG")
        when "PO4" then loop.physical_details = consume("PO4")
        when "ITD" then loop.terms_of_sale << consume("ITD")
        when "REF" then loop.references << consume("REF")
        when "YNQ" then loop.yes_no_questions << consume("YNQ")
        when "PER" then loop.contacts << consume("PER")
        when "SDQ" then loop.destination_quantities << consume("SDQ")
        when "DTM" then loop.dates << consume("DTM")
        when "CAD" then loop.carriers << consume("CAD")
        when "L7"  then loop.tariffs << consume("L7")
        when "SR"  then loop.service_schedule = consume("SR")
        when "SAC" then loop.sac_loops << parse_sac_loop
        when "SLN" then loop.sln_loops << parse_sln_loop
        when "N1"  then loop.n1_loops << parse_n1_loop
        when "FA1" then loop.fa1_loops << parse_fa1_loop
        when "LM"  then loop.lm_loops << parse_lm_loop
        else
          break
        end
      end

      loop
    end

    def parse_sac_loop
      loop = Loops::SACLoop.new
      loop.sac = consume("SAC")

      while current_id == "TXI"
        loop.taxes << consume("TXI")
      end

      loop
    end

    def parse_pid_loop
      loop = Loops::PIDLoop.new
      loop.pid = consume("PID")

      while current_id == "MEA"
        loop.measurements << consume("MEA")
      end

      loop
    end

    def parse_sln_loop
      loop = Loops::SLNLoop.new
      loop.sln = consume("SLN")

      while current_id && %w[DTM REF PID SAC].include?(current_id)
        case current_id
        when "DTM" then loop.dates << consume("DTM")
        when "REF" then loop.references << consume("REF")
        when "PID" then loop.descriptions << consume("PID")
        when "SAC" then loop.sac_loops << parse_sac_loop
        else break
        end
      end

      loop
    end

    def parse_lm_loop
      loop = Loops::LMLoop.new
      loop.lm = consume("LM")

      while current_id == "LQ"
        loop.lqs << consume("LQ")
      end

      loop
    end

    def parse_n9_loop
      loop = Loops::N9Loop.new
      loop.n9 = consume("N9")

      while current_id == "MSG"
        loop.messages << consume("MSG")
      end

      loop
    end

    def parse_v1_loop
      loop = Loops::V1Loop.new
      loop.v1 = consume("V1")

      while current_id && %w[R4 DTM].include?(current_id)
        case current_id
        when "R4"  then loop.ports << consume("R4")
        when "DTM" then loop.dates << consume("DTM")
        else break
        end
      end

      loop
    end

    def parse_fa1_loop
      loop = Loops::FA1Loop.new
      loop.fa1 = consume("FA1")

      while current_id == "FA2"
        loop.fa2s << consume("FA2")
      end

      loop
    end

    # -- Helpers --

    def n1_child?(id)
      N1_LOOP_TRIGGERS.include?(id)
    end

    def it1_child?(id)
      IT1_CHILD_IDS.include?(id)
    end
  end
end
