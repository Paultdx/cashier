# frozen_string_literal: true

module PricingRules
  class Percentage < BaseRule
    attr_reader :min_quantity, :discount_percentage

    def initialize(min_quantity, discount_percentage)
      @min_quantity = min_quantity
      @discount_percentage = discount_percentage
    end

    def applicable?(quantity)
      quantity >= min_quantity
    end

    def calculate_price(product_info)
      discounted_price = product_info[:price] * discount_percentage
      product_info[:quantity] * discounted_price
    end
  end
end
