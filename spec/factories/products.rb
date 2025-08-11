# frozen_string_literal: true

require "./lib/models/product"

FactoryBot.define do
  factory :product, class: Models::Product do
    code { Faker::Name.unique.name }
    name { Faker::ProgrammingLanguage.unique.name }
    price { Faker::Commerce.price(range: 0.01..100.00) }
    currency { Money::Currency.all.sample }

    initialize_with { new(code:, name:, price:, currency:) }

    trait :green_tea do
      code { "GR1" }
      name { "Green tea" }
      price { 3.11 }
      currency { Money::Currency.find("GBP") }
    end

    trait :strawberries do
      code { "SR1" }
      name { "Strawberries" }
      price { 5.00 }
      currency { Money::Currency.find("GBP") }
    end

    trait :coffee do
      code { "CF1" }
      name { "Coffee" }
      price { 11.23 }
      currency { Money::Currency.find("GBP") }
    end

    trait :with_the_same_currency do
      currency { Money::Currency.find("GBP") }
    end
  end
end
