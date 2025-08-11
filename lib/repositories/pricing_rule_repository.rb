# frozen_string_literal: true

module Repositories
  class PricingRuleRepository
    attr_reader :rules

    def initialize
      @rules = {}
    end

    def add(pricing_rule, product_code)
      @rules[product_code] = pricing_rule
    end
  end
end
