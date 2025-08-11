# frozen_string_literal: true

RSpec.describe PricingRules::Percentage do
  let(:min_quantity) { Faker::Number.between(from: 10, to: 20) }
  let(:discount_percentage) { 2.0 / 3.0 }

  subject { described_class.new(min_quantity, discount_percentage) }

  it_should_behave_like "a_base_rule"
  it_should_behave_like "it_has_min_quantity_check"

  context "when rule is applicable" do
    let(:original_price) { 1123 }

    describe "#calculate_price" do
      it "applies percentage discount for minimum quantity" do
        product_info = { quantity: 3, price: original_price }
        discounted_price = (original_price * discount_percentage)
        expected_price = 3 * discounted_price

        expect(subject.calculate_price(product_info)).to eq(expected_price)
      end

      it "applies percentage discount for higher quantities" do
        product_info = { quantity: 5, price: original_price }
        discounted_price = (original_price * discount_percentage)
        expected_price = 5 * discounted_price

        expect(subject.calculate_price(product_info)).to eq(expected_price)
      end

      context "with different discount percentages" do
        let(:min_quantity) { 1 }
        let(:fifty_percent) { 0.5 }

        subject { described_class.new(min_quantity, fifty_percent) }

        it "applies 50% discount correctly" do
          product_info = { quantity: 4, price: 1000 }
          expected_price = 4 * 500

          expect(subject.calculate_price(product_info)).to eq(expected_price)
        end
      end

      context "with edge case percentages" do
        let(:min_quantity) { 1 }
        let(:zero_percent) { 0.0 }

        subject { described_class.new(min_quantity, zero_percent) }

        it "handles zero discount (free items)" do
          product_info = { quantity: 2, price: 1000 }
          expected_price = 0

          expect(subject.calculate_price(product_info)).to eq(expected_price)
        end
      end

      context "with fractional results" do
        it "handles fractional pricing correctly" do
          product_info = { quantity: 3, price: 1123 }

          discounted_price = (1123 * (2.0 / 3.0))
          expected_price = 3 * discounted_price

          expect(subject.calculate_price(product_info)).to eq(expected_price)
        end
      end
    end
  end
end
