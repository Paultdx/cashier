# frozen_string_literal: true

module PricingRules
  class BaseRule
    def applicable?(quantity)
      raise NotImplementedError, "This method should be overridden in a subclass"
    end

    def calculate_price(product_info)
      raise NotImplementedError, "This method should be overridden in a subclass"
    end
  end
end
