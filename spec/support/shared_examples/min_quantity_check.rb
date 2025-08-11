# frozen_string_literal: true

RSpec.shared_examples "it_has_min_quantity_check" do
  describe "#applicable?" do
    context "when quantity is below minimum" do
      it "returns false for quantity lower than min_quantity" do
        expect(subject.applicable?(Faker::Number.non_zero_digit)).to be false
      end
    end

    context "when quantity meets minimum" do
      it "returns true for quantity equals min_quantity" do
        expect(subject.applicable?(min_quantity)).to be true
      end
    end

    context "when quantity is above minimum" do
      it "returns true for quantity above min_quantity" do
        expect(subject.applicable?(Faker::Number.number(digits: 3))).to be true
      end
    end
  end
end
