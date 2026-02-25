# frozen_string_literal: true

RSpec.describe Edi810::Parser do
  let(:sample_input) { read_fixture("sample_810.edi") }
  let(:minimal_input) { read_fixture("minimal_810.edi") }

  describe "#parse" do
    context "with sample_810.edi" do
      let(:doc) { Edi810.parse(sample_input) }

      it "parses ISA segment" do
        expect(doc.isa).to be_a(Edi810::Segments::ISA)
        expect(doc.sender_id).to eq("SENDER")
        expect(doc.receiver_id).to eq("RECEIVER")
      end

      it "parses GS segment" do
        expect(doc.gs).to be_a(Edi810::Segments::GS)
        expect(doc.gs.functional_identifier_code).to eq("IN")
      end

      it "parses ST segment with 810 identifier" do
        expect(doc.st.transaction_set_identifier_code).to eq("810")
        expect(doc.transaction_control_number).to eq("0001")
      end

      it "parses BIG segment with invoice details" do
        expect(doc.invoice_number).to eq("INV-001")
        expect(doc.invoice_date).to eq(Date.new(2021, 3, 15))
        expect(doc.purchase_order_number).to eq("PO-12345")
        expect(doc.purchase_order_date).to eq(Date.new(2021, 3, 1))
      end

      it "parses NTE notes" do
        expect(doc.notes.size).to eq(1)
        expect(doc.notes.first.description).to eq("This is a test invoice")
      end

      it "parses REF references" do
        expect(doc.references.size).to eq(2)
        expect(doc.references.first.reference_identification_qualifier).to eq("VR")
        expect(doc.references.first.reference_identification).to eq("VENDOR-REF-001")
      end

      it "parses N1 loops (Bill To, Ship To, Remit To)" do
        expect(doc.n1_loops.size).to eq(3)

        bt = doc.bill_to
        expect(bt).not_to be_nil
        expect(bt.name).to eq("Acme Corp")
        expect(bt.city).to eq("New York")
        expect(bt.state).to eq("NY")
        expect(bt.postal_code).to eq("10001")

        st = doc.ship_to
        expect(st).not_to be_nil
        expect(st.name).to eq("Warehouse Inc")
        expect(st.city).to eq("Chicago")

        re = doc.remit_to
        expect(re).not_to be_nil
        expect(re.name).to eq("Remit Corp")
      end

      it "parses ITD terms of sale" do
        expect(doc.terms_of_sale.size).to eq(1)
        itd = doc.terms_of_sale.first
        expect(itd.terms_type_code).to eq("01")
        expect(itd.terms_net_days).to eq(30)
      end

      it "parses DTM dates" do
        expect(doc.dates.size).to eq(1)
        expect(doc.dates.first.date_time_qualifier).to eq("011")
      end

      it "parses three IT1 line items" do
        expect(doc.line_items.size).to eq(3)
      end

      it "parses first line item correctly" do
        li = doc.line_items[0]
        expect(li.line_number).to eq("1")
        expect(li.quantity).to eq(BigDecimal("10"))
        expect(li.unit_of_measure).to eq("EA")
        expect(li.unit_price).to eq(BigDecimal("25.50"))
        expect(li.product_id_qualifier).to eq("UP")
        expect(li.product_id).to eq("012345678901")
        expect(li.description).to eq("Widget Type A")
      end

      it "parses second line item with SAC loop" do
        li = doc.line_items[1]
        expect(li.quantity).to eq(BigDecimal("5"))
        expect(li.unit_price).to eq(BigDecimal("15"))
        expect(li.sac_loops.size).to eq(1)
        expect(li.sac_loops.first.sac.allowance_or_charge_indicator).to eq("C")
      end

      it "parses third line item with TXI" do
        li = doc.line_items[2]
        expect(li.quantity).to eq(BigDecimal("20"))
        expect(li.taxes.size).to eq(1)
        expect(li.taxes.first.tax_type_code).to eq("ST")
      end

      it "parses TDS total" do
        expect(doc.total_amount).to eq(BigDecimal("52363"))
      end

      it "parses summary TXI" do
        expect(doc.summary_taxes.size).to eq(1)
        expect(doc.summary_taxes.first.tax_type_code).to eq("GS")
      end

      it "parses summary CAD" do
        expect(doc.summary_carrier).to be_a(Edi810::Segments::CAD)
        expect(doc.summary_carrier.routing).to eq("UPS GROUND")
      end

      it "parses CTT totals" do
        expect(doc.ctt.number_of_line_items).to eq(3)
        expect(doc.ctt.hash_total).to eq(BigDecimal("35"))
      end

      it "parses SE trailer" do
        expect(doc.se.number_of_included_segments).to eq(29)
        expect(doc.se.transaction_set_control_number).to eq("0001")
      end

      it "parses GE and IEA trailers" do
        expect(doc.ge.number_of_transaction_sets_included).to eq(1)
        expect(doc.iea.number_of_included_functional_groups).to eq(1)
      end
    end

    context "with minimal_810.edi" do
      let(:doc) { Edi810.parse(minimal_input) }

      it "parses minimal invoice" do
        expect(doc.invoice_number).to eq("INV-MINIMAL")
        expect(doc.line_items.size).to eq(1)
        expect(doc.total_amount).to eq(BigDecimal("10000"))
      end
    end
  end
end
