# frozen_string_literal: true

RSpec.describe Edi810::Tokenizer do
  let(:input) { read_fixture("sample_810.edi") }
  let(:tokenizer) { described_class.new(input) }

  describe "#initialize" do
    it "detects element separator" do
      expect(tokenizer.element_separator).to eq("*")
    end

    it "detects sub-element separator" do
      expect(tokenizer.sub_element_separator).to eq(":")
    end

    it "detects segment terminator" do
      expect(tokenizer.segment_terminator).to eq("~")
    end

    it "raises on non-ISA input" do
      expect { described_class.new("GS*IN*SENDER~") }
        .to raise_error(Edi810::TokenizeError, /must start with an ISA/)
    end

    it "raises on short input" do
      expect { described_class.new("ISA*00*") }
        .to raise_error(Edi810::TokenizeError, /too short/)
    end
  end

  describe "#tokenize" do
    let(:tokens) { tokenizer.tokenize }

    it "returns an array of SegmentTokens" do
      expect(tokens).to all(be_a(Edi810::Tokenizer::SegmentToken))
    end

    it "starts with ISA" do
      expect(tokens.first.id).to eq("ISA")
    end

    it "ends with IEA" do
      expect(tokens.last.id).to eq("IEA")
    end

    it "splits elements correctly for BIG segment" do
      big_token = tokens.find { |t| t.id == "BIG" }
      expect(big_token.elements[1]).to eq("20210315")
      expect(big_token.elements[2]).to eq("INV-001")
    end
  end

  context "with newline-terminated EDI (no ~ or :)" do
    let(:input) { read_fixture("newline_terminated_810.edi") }

    describe "#initialize" do
      it "detects element separator" do
        expect(tokenizer.element_separator).to eq("*")
      end

      it "detects sub-element separator from ISA16" do
        expect(tokenizer.sub_element_separator).to eq(">")
      end

      it "falls back to newline as segment terminator" do
        expect(tokenizer.segment_terminator).to eq("\n")
      end
    end

    describe "#tokenize" do
      let(:tokens) { tokenizer.tokenize }

      it "returns the correct number of segments" do
        expect(tokens.length).to eq(9)
      end

      it "starts with ISA and ends with IEA" do
        expect(tokens.first.id).to eq("ISA")
        expect(tokens.last.id).to eq("IEA")
      end

      it "parses BIG segment elements correctly" do
        big_token = tokens.find { |t| t.id == "BIG" }
        expect(big_token.elements[1]).to eq("20210315")
        expect(big_token.elements[2]).to eq("INV-NL")
      end

      it "parses IT1 segment elements correctly" do
        it1_token = tokens.find { |t| t.id == "IT1" }
        expect(it1_token.elements[3]).to eq("EA")
        expect(it1_token.elements[4]).to eq("50.00")
      end
    end
  end
end
