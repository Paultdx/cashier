# frozen_string_literal: true

RSpec.describe "integration" do
  let(:green_tea) { build(:product, :green_tea) }
  let(:strawberries) { build(:product, :strawberries) }
  let(:coffee) { build(:product, :coffee) }
  let(:pricing_rules) { Repositories::PricingRuleRepository.new }
  let(:checkout) { Services::Checkout.new(pricing_rules) }

  before do
    pricing_rules.add(PricingRules::BuyOneGetOneFree.new, "GR1")
    pricing_rules.add(PricingRules::Bulk.new(3, Money.from_amount(4.50, "GBP")), "SR1")
    pricing_rules.add(PricingRules::Percentage.new(3, 2.0 / 3.0), "CF1")
  end

  context "when basket has GR1,SR1,GR1,GR1,CF1 product codes" do
    before do
      checkout.scan(green_tea)
      checkout.scan(strawberries)
      checkout.scan(green_tea)
      checkout.scan(green_tea)
      checkout.scan(coffee)
    end

    it "calculates the total price correctly" do
      expect(Presenters::OrderPresenter.new(checkout.total_amount)
                                       .present_for_web).to eq(Money.from_cents(2245, "GBP").round.format)
    end
  end

  context "when basket has GR1,GR1 product codes" do
    before do
      checkout.scan(green_tea)
      checkout.scan(green_tea)
    end

    it "calculates the total price correctly" do
      expect(Presenters::OrderPresenter.new(checkout.total_amount)
                                       .present_for_web).to eq(Money.from_cents(311, "GBP").round.format)
    end
  end

  context "when basket has SR1,SR1,GR1,SR1 product codes" do
    before do
      checkout.scan(strawberries)
      checkout.scan(strawberries)
      checkout.scan(green_tea)
      checkout.scan(strawberries)
    end

    it "calculates the total price correctly" do
      expect(Presenters::OrderPresenter.new(checkout.total_amount)
                                       .present_for_web).to eq(Money.from_cents(1661, "GBP").round.format)
    end
  end

  context "when basket has GR1,CF1,SR1,CF1,CF1 product codes" do
    before do
      checkout.scan(green_tea)
      checkout.scan(coffee)
      checkout.scan(strawberries)
      checkout.scan(coffee)
      checkout.scan(coffee)
    end

    it "calculates the total price correctly" do
      expect(Presenters::OrderPresenter.new(checkout.total_amount)
                                       .present_for_web).to eq(Money.from_cents(3057, "GBP").round.format)
    end
  end
end
