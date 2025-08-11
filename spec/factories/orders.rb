# frozen_string_literal: true

require "./lib/models/order"

FactoryBot.define do
  factory :order, class: Models::Order do
    cart { FactoryBot.build_list(:product, Faker::Number.non_zero_digit, :with_the_same_currency) }
    total { nil }

    after :build do |order|
      order.cart = order.cart.each_with_object({}) do |product, hash|
        hash[product.code] = { quantity: 1, name: product.name, price: product.price }
      end
    end
  end
end
