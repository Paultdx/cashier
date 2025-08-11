# frozen_string_literal: true

RSpec.describe PricingRules::BaseRule do
  describe "#applicable?" do
    it "raises NotImplementedError" do
      expect { subject.applicable?(1) }.to raise_error(NotImplementedError)
    end
  end

  describe "#calculate_price" do
    it "raises NotImplementedError" do
      product_info = { quantity: 1, price: 100 }
      expect { subject.calculate_price(product_info) }.to raise_error(NotImplementedError)
    end
  end
end
