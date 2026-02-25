# frozen_string_literal: true

RSpec.describe Edi810::Document do
  let(:input) { read_fixture("sample_810.edi") }
  let(:doc) { Edi810.parse(input) }

  describe "convenience accessors" do
    it "#invoice_number" do
      expect(doc.invoice_number).to eq("INV-001")
    end

    it "#invoice_date" do
      expect(doc.invoice_date).to eq(Date.new(2021, 3, 15))
    end

    it "#purchase_order_number" do
      expect(doc.purchase_order_number).to eq("PO-12345")
    end

    it "#total_amount" do
      expect(doc.total_amount).to eq(BigDecimal("52363"))
    end

    it "#line_item_count" do
      expect(doc.line_item_count).to eq(3)
    end

    it "#sender_id and #receiver_id" do
      expect(doc.sender_id).to eq("SENDER")
      expect(doc.receiver_id).to eq("RECEIVER")
    end
  end

  describe "#party" do
    it "finds Bill To party" do
      bt = doc.party("BT")
      expect(bt).not_to be_nil
      expect(bt.name).to eq("Acme Corp")
    end

    it "returns nil for unknown party code" do
      expect(doc.party("XX")).to be_nil
    end
  end

  describe "#to_h" do
    it "returns a hash representation" do
      h = doc.to_h
      expect(h[:big][:invoice_number]).to eq("INV-001")
      expect(h[:line_items].size).to eq(3)
    end
  end

  describe "#all_segments" do
    it "returns ordered list of all segments" do
      segs = doc.all_segments
      ids = segs.map(&:segment_id)
      expect(ids.first).to eq("ISA")
      expect(ids.last).to eq("IEA")
      expect(ids).to include("BIG", "IT1", "TDS", "SE")
    end
  end
end
