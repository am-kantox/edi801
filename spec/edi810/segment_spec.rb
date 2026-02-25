# frozen_string_literal: true

RSpec.describe Edi810::Segment do
  describe "BIG segment" do
    let(:elements) { ["BIG", "20210315", "INV-001", "20210301", "PO-12345"] }
    let(:big) { Edi810::Segments::BIG.new(elements) }

    it "parses date elements" do
      expect(big.invoice_date).to eq(Date.new(2021, 3, 15))
    end

    it "parses string elements" do
      expect(big.invoice_number).to eq("INV-001")
    end

    it "parses optional date" do
      expect(big.purchase_order_date).to eq(Date.new(2021, 3, 1))
    end

    it "returns nil for absent elements" do
      expect(big.transaction_type_code).to be_nil
    end

    it "converts to hash" do
      h = big.to_h
      expect(h[:invoice_number]).to eq("INV-001")
      expect(h[:invoice_date]).to eq(Date.new(2021, 3, 15))
    end

    it "serializes to EDI" do
      edi = big.to_edi
      expect(edi).to start_with("BIG*")
      expect(edi).to include("INV-001")
    end
  end

  describe "IT1 segment" do
    let(:elements) { ["IT1", "1", "10", "EA", "25.50", "", "UP", "012345678901", "VP", "SKU-100"] }
    let(:it1) { Edi810::Segments::IT1.new(elements) }

    it "parses decimal quantity" do
      expect(it1.quantity_invoiced).to eq(BigDecimal("10"))
    end

    it "parses decimal unit price" do
      expect(it1.unit_price).to eq(BigDecimal("25.50"))
    end

    it "parses product ID qualifier pairs" do
      expect(it1.product_service_id_qualifier).to eq("UP")
      expect(it1.product_service_id).to eq("012345678901")
      expect(it1.product_service_id_qualifier2).to eq("VP")
      expect(it1.product_service_id2).to eq("SKU-100")
    end
  end

  describe "TDS segment" do
    let(:elements) { ["TDS", "52363"] }
    let(:tds) { Edi810::Segments::TDS.new(elements) }

    it "parses total invoice amount as decimal" do
      expect(tds.total_invoice_amount).to eq(BigDecimal("52363"))
    end
  end

  describe "segment registry" do
    it "registers all 52 segment types" do
      expect(Edi810.segment_registry.size).to be >= 52
    end

    it "finds segment class by ID" do
      expect(Edi810.segment_class_for("BIG")).to eq(Edi810::Segments::BIG)
      expect(Edi810.segment_class_for("IT1")).to eq(Edi810::Segments::IT1)
      expect(Edi810.segment_class_for("ISA")).to eq(Edi810::Segments::ISA)
    end

    it "returns nil for unknown segment IDs" do
      expect(Edi810.segment_class_for("ZZZ")).to be_nil
    end
  end
end
