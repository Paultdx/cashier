# frozen_string_literal: true

RSpec.describe PricingRules::BuyOneGetOneFree do
  subject { described_class.new }

  it_should_behave_like "a_base_rule"

  context "when rule is applicable" do
    describe "#calculate_price" do
      let(:price) { 311 }

      context "with even quantities" do
        it "charges for half the items when quantity is 2" do
          product_info = { quantity: 2, price: price }
          expected_price = 1 * price

          expect(subject.calculate_price(product_info)).to eq(expected_price)
        end

        it "charges for half the items when quantity is 4" do
          product_info = { quantity: 4, price: price }
          expected_price = 2 * price

          expect(subject.calculate_price(product_info)).to eq(expected_price)
        end
      end

      context "with odd quantities" do
        it "rounds up when quantity is 3" do
          product_info = { quantity: 3, price: price }
          expected_price = 2 * price # (3 + 1) / 2 = 2

          expect(subject.calculate_price(product_info)).to eq(expected_price)
        end

        it "rounds up when quantity is 5" do
          product_info = { quantity: 5, price: price }
          expected_price = 3 * price # (5 + 1) / 2 = 3

          expect(subject.calculate_price(product_info)).to eq(expected_price)
        end
      end

      context "with edge cases" do
        it "handles quantity 1" do
          product_info = { quantity: 1, price: price }
          expected_price = 1 * price

          expect(subject.calculate_price(product_info)).to eq(expected_price)
        end

        it "handles quantity 0" do
          product_info = { quantity: 0, price: price }
          expected_price = 0

          expect(subject.calculate_price(product_info)).to eq(expected_price)
        end
      end
    end
  end
end
