# frozen_string_literal: true

RSpec.describe Presenters::OrderPresenter do
  let(:checkout) { { item1: Money.from_amount(1000, "GBP"), item2: Money.from_amount(2000, "GBP") } }
  let(:presenter) { described_class.new(checkout) }

  describe "#present_for_web" do
    it "returns the formatted total amount" do
      expect(presenter.present_for_web).to eq(Money.from_amount(3000, "GBP").round.format)
    end
  end
end
