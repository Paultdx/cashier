# frozen_string_literal: true

RSpec.describe Services::OrderPriceCalculator do
  let(:order) { build(:order) }
  let(:pricing_rules) { Repositories::PricingRuleRepository.new }

  subject { described_class.new(order, pricing_rules.rules) }

  describe "#call" do
    context "when rules are applicable" do
      let(:product) { build(:product, code: "ZXC", price: 10.00, currency: "GBP") }
      let(:order) { Models::Order.new }
      let(:applicable_rule) { PricingRules::BuyOneGetOneFree.new }

      before do
        pricing_rules.add(applicable_rule, "ZXC")

        3.times do
          order.add_item(product)
        end
      end

      it "returns the total price with rules" do
        result = subject.call.values.sum

        expect(result).to eq(Money.from_amount(20.00, "GBP"))
      end
    end

    context "when rules are not applicable" do
      let(:inapplicable_rule) { PricingRules::BuyOneGetOneFree.new }

      before do
        pricing_rules.add("ZXC", inapplicable_rule)
      end

      it "returns the total price without applying any rules" do
        result = subject.call.values.sum

        expect(result).to eq(order.total.values.sum)
      end
    end
  end
end
