# frozen_string_literal: true

require "require_all"
require "money"

require_relative "../config/config"
require_all "lib/models"
require_all "lib/presenters"
require_all "lib/pricing_rules"
require_all "lib/repositories"
require_all "lib/services"


product1 = Models::Product.new(code: "GR1", name: "Green tea", price: 3.11, currency: "GBP")
product2 = Models::Product.new(code: "SR1", name: "Strawberries", price: 5.00, currency: "GBP")
product3 = Models::Product.new(code: "CF1", name: "Coffee", price: 11.23, currency: "GBP")

pricing_rules = Repositories::PricingRuleRepository.new

pricing_rules.add(PricingRules::BuyOneGetOneFree.new, "GR1")
pricing_rules.add(PricingRules::Bulk.new(3, Money.from_amount(4.50, "GBP")), "SR1")
pricing_rules.add(PricingRules::Percentage.new(3, 2.0 / 3.0), "CF1")

checkout = Services::Checkout.new(pricing_rules)

checkout.scan(product2)
checkout.scan(product2)
checkout.scan(product1)
checkout.scan(product2)
checkout.scan(product3)
checkout.scan(product3)

puts Presenters::OrderPresenter.new(checkout.total_amount).present_for_web
