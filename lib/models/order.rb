# frozen_string_literal: true

module Models
  class Order
    attr_accessor :cart, :total

    def initialize
      @cart = {}
    end

    def add_item(product)
      validate_product(product)

      cart.key?(product.code) ? increment_item(product) : new_item(product)
    end

    private

    def validate_product(product)
      raise ArgumentError, "Invalid product #{product}" unless product.is_a?(Models::Product)
    end

    def increment_item(product)
      cart[product.code][:quantity] += 1
    end

    def new_item(product)
      cart[product.code] = { quantity: 1, price: product.price }
    end
  end
end
