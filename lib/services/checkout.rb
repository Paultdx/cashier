# frozen_string_literal: true

require_relative "../models/order"
require_relative "order_price_calculator"

module Services
  class Checkout
    attr_reader :order, :pricing_rules

    def initialize(pricing_rules)
      @order = Models::Order.new
      @pricing_rules = pricing_rules
    end

    def scan(item)
      order.add_item(item)
    end

    def total_amount
      Services::OrderPriceCalculator.new(order, pricing_rules.rules).call
    end
  end
end
