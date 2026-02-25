# frozen_string_literal: true

RSpec.describe Edi810::Generator do
  let(:sample_input) { read_fixture("sample_810.edi") }
  let(:doc) { Edi810.parse(sample_input) }

  describe "#generate" do
    it "produces valid EDI output" do
      output = Edi810.generate(doc)
      expect(output).to be_a(String)
      expect(output).to include("ISA*")
      expect(output).to include("BIG*")
      expect(output).to include("TDS*")
      expect(output).to include("IEA*")
    end

    it "round-trips through parse and generate" do
      output = Edi810.generate(doc)
      reparsed = Edi810.parse(output)

      expect(reparsed.invoice_number).to eq(doc.invoice_number)
      expect(reparsed.purchase_order_number).to eq(doc.purchase_order_number)
      expect(reparsed.line_items.size).to eq(doc.line_items.size)
      expect(reparsed.total_amount).to eq(doc.total_amount)
      expect(reparsed.ctt.number_of_line_items).to eq(doc.ctt.number_of_line_items)
    end

    it "preserves line item data through round-trip" do
      output = Edi810.generate(doc)
      reparsed = Edi810.parse(output)

      doc.line_items.each_with_index do |original, idx|
        reparsed_item = reparsed.line_items[idx]
        expect(reparsed_item.quantity).to eq(original.quantity)
        expect(reparsed_item.unit_price).to eq(original.unit_price)
        expect(reparsed_item.product_id).to eq(original.product_id)
      end
    end

    it "uses custom delimiters" do
      gen = described_class.new(element_separator: "|", segment_terminator: "#")
      output = gen.generate(doc)
      expect(output).to include("ISA|")
      expect(output).to include("#")
      expect(output).not_to include("ISA*")
    end

    it "raises on empty document" do
      empty_doc = Edi810::Document.new
      expect { Edi810.generate(empty_doc) }.to raise_error(Edi810::GeneratorError)
    end
  end
end
