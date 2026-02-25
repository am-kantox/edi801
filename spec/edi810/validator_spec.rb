# frozen_string_literal: true

RSpec.describe Edi810::Validator do
  let(:sample_input) { read_fixture("sample_810.edi") }
  let(:doc) { Edi810.parse(sample_input) }

  describe "#validate" do
    context "with valid document" do
      it "returns valid result" do
        result = Edi810.validate(doc)
        expect(result.valid?).to be true
        expect(result.errors).to be_empty
      end
    end

    context "with missing BIG segment" do
      it "reports missing BIG" do
        doc.big = nil
        result = Edi810.validate(doc)
        expect(result.valid?).to be false
        expect(result.errors.any? { |e| e.segment_id == "BIG" && e.code == :missing_segment }).to be true
      end
    end

    context "with missing TDS segment" do
      it "reports missing TDS" do
        doc.tds = nil
        result = Edi810.validate(doc)
        expect(result.valid?).to be false
        expect(result.errors.any? { |e| e.segment_id == "TDS" }).to be true
      end
    end

    context "with control number mismatch" do
      it "reports ST02/SE02 mismatch" do
        doc.se.transaction_set_control_number = "9999"
        result = Edi810.validate(doc)
        expect(result.valid?).to be false
        expect(result.errors.any? { |e| e.code == :control_number_mismatch && e.segment_id == "SE" }).to be true
      end
    end

    context "with CTT line count mismatch" do
      it "reports CTT count mismatch" do
        doc.ctt.number_of_line_items = 99
        result = Edi810.validate(doc)
        expect(result.valid?).to be false
        expect(result.errors.any? { |e| e.code == :ctt_count_mismatch }).to be true
      end
    end

    context "with CTT hash total mismatch" do
      it "reports hash total mismatch" do
        doc.ctt.hash_total = BigDecimal("999")
        result = Edi810.validate(doc)
        expect(result.valid?).to be false
        expect(result.errors.any? { |e| e.code == :ctt_hash_mismatch }).to be true
      end
    end
  end
end
