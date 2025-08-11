# frozen_string_literal: true

RSpec.describe Models::Order do
  subject { described_class.new }

  describe "#initialize" do
    context "when an empty order" do
      it "creates an order with no items" do
        expect(subject.cart).to be_empty
        expect(subject.cart.class).to eq(Hash)
      end
    end
  end

  describe "#add_item" do
    before do
      allow(product).to receive(:is_a?).with(Models::Product).and_return(true)
    end

    context "when product is already in the cart" do
      let(:product) do
        instance_double(Models::Product, code: "GR1", name: "Green tea", price: Money.from_amount(3.11),
                                         currency: "GBP")
      end

      before do
        subject.add_item(product)
      end

      it "increases the quantity of the product in the cart" do
        expect { subject.add_item(product) }.to change { subject.cart[product.code][:quantity] }.by(1)
      end
    end

    context "when product is not in the cart" do
      let(:product) do
        instance_double(Models::Product, code: "GR1", name: "Green tea", price: Money.from_amount(3.11),
                                         currency: "GBP")
      end

      it "adds the product to the cart with quantity 1" do
        subject.add_item(product)

        expect(subject.cart[product.code][:quantity]).to eq 1
      end
    end
  end
end
