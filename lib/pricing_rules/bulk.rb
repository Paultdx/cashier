# frozen_string_literal: true

module PricingRules
  class Bulk < BaseRule
    attr_reader :min_quantity, :fixed_price

    def initialize(min_quantity, fixed_price)
      @min_quantity = min_quantity
      @fixed_price = fixed_price
    end

    def applicable?(quantity)
      quantity >= min_quantity
    end

    def calculate_price(product_info)
      fixed_price * product_info[:quantity]
    end
  end
end
