# frozen_string_literal: true

module PricingRules
  class BuyOneGetOneFree < BaseRule
    def applicable?(quantity)
      quantity >= 2
    end

    def calculate_price(product_info)
      (product_info[:quantity] + 1) / 2 * product_info[:price]
    end
  end
end
