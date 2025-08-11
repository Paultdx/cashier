# frozen_string_literal: true

RSpec.describe PricingRules::Bulk do
  let(:min_quantity) { Faker::Number.between(from: 10, to: 20) }
  let(:discounted_price) { Faker::Number.between(from: 100, to: 500) }

  subject { described_class.new(min_quantity, discounted_price) }

  it_should_behave_like "a_base_rule"
  it_should_behave_like "it_has_min_quantity_check"

  context "when rule is applicable" do
    describe "#calculate_price" do
      let(:discounted_price) { Faker::Number.between(from: 100, to: 500) }

      it "calculates price based on fixed price and quantity" do
        product_info = { quantity: Faker::Number.non_zero_digit }

        expect(subject.calculate_price(product_info)).to eq(discounted_price * product_info[:quantity])
      end
    end
  end
end
