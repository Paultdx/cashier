# frozen_string_literal: true

require "money"

module Models
  class Product
    attr_reader :code, :name, :price, :currency

    def initialize(code:, name:, price:, currency:)
      @code = code
      @name = name
      @price = Money.from_amount(price, currency) if valid_currency?(currency)
    end

    private

    def valid_currency?(currency)
      return true if Money::Currency.find(currency)

      raise ArgumentError, "Invalid currency: #{currency}"
    end
  end
end
