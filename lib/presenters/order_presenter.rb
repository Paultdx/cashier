# frozen_string_literal: true

module Presenters
  class OrderPresenter
    attr_reader :checkout

    def initialize(checkout)
      @checkout = checkout
    end

    def present_for_web
      total = checkout.values.sum

      Money.from_cents(total).round.format
    end
  end
end
