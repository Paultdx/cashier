# frozen_string_literal: true

RSpec.describe Models::Product do
  subject { described_class.new(code:, name:, price:, currency:) }

  describe "#initialize" do
    context "when product attributes are valid" do
      let(:code) { "PZZ" }
      let(:name) { "Pizza" }
      let(:price) { 10.52 }
      let(:currency) { "USD" }

      it "creates a product with the given attributes" do
        expect(subject.code).to eq("PZZ")
        expect(subject.name).to eq("Pizza")
        expect(subject.price).to eq(Money.from_amount(10.52, "USD"))
      end
    end

    context "when product attributes are invalid" do
      let(:code) { "PLL" }
      let(:name) { "Paella" }
      let(:price) { 10_000.00 }
      let(:currency) { "ZXC" }

      it "raises an ArgumentError for invalid currency" do
        expect { subject }.to raise_error(ArgumentError, "Invalid currency: ZXC")
      end
    end
  end
end
