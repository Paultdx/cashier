# frozen_string_literal: true

RSpec.describe Repositories::PricingRuleRepository do
  let(:product_code) { "GR1" }
  let(:pricing_rule) { instance_double(PricingRules::BaseRule) }

  subject { described_class.new }

  describe "#add" do
    context "with valid parameters" do
      it "adds a pricing rule for a product code" do
        expect { subject.add(pricing_rule, product_code) }.to change { subject.rules.size }.by(1)

        expect(subject.rules[product_code]).to eq(pricing_rule)
      end
    end
  end
end
