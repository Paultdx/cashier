# frozen_string_literal: true

module Services
  class OrderPriceCalculator
    attr_reader :order, :rules

    def initialize(order, rules)
      @order = order
      @rules = rules
    end

    def call
      total = {}

      order.cart.each do |product_code, product_info|
        total[product_code] = calculate_product_total(product_code, product_info)
      end

      order.total = total
    end

    private

    def calculate_product_total(product_code, product_info)
      applicable_rule = rules[product_code]

      if applicable_rule.nil?
        calculate_regular_price(product_info)
      else
        calculate_best_price(product_info, applicable_rule)
      end
    end

    def calculate_best_price(product_info, rule)
      if rule.applicable?(product_info[:quantity])
        rule.calculate_price(product_info)
      else
        calculate_regular_price(product_info)
      end
    end

    def calculate_regular_price(product_info)
      product_info[:price] * product_info[:quantity]
    end
  end
end
