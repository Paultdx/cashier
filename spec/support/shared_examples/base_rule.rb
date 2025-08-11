# frozen_string_literal: true

RSpec.shared_examples "a_base_rule" do
  it "inherits from BaseRule" do
    expect(subject).to be_a(PricingRules::BaseRule)
  end
end
