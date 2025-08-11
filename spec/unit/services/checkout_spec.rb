# frozen_string_literal: true

RSpec.describe Services::Checkout do
  let(:products) { build_list(:product, Faker::Number.non_zero_digit, :with_the_same_currency) }
  let(:pricing_rules) { Repositories::PricingRuleRepository.new }

  subject { Services::Checkout.new(pricing_rules) }

  describe "#scan" do
    it "adds products to the order" do
      products.each { |product| subject.scan(product) }

      expect(subject.order.cart.keys).to eq(products.map(&:code))
      expect(subject.order.cart.keys.count).to eq(products.count)
    end
  end

  describe "#total_amount" do
    let(:products) { build_list(:product, 2, :green_tea) }
    let(:green_tea_price) { { "GR1" => products.first.price } }
    let(:pricing_rules) { Repositories::PricingRuleRepository.new }
    let(:rule) { PricingRules::BuyOneGetOneFree.new }

    before do
      pricing_rules.add(rule, "GR1")
    end

    it "calculates correct total_amount for the order" do
      products.each { |product| subject.scan(product) }

      expect(subject.total_amount).to eq(green_tea_price)
    end
  end
end
