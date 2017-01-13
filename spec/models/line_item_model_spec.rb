require 'rails_helper.rb'

describe LineItem do
  let(:line_item) { create(:line_item) }

  it { expect( create(:line_item) ).to be_valid }

  describe "ActiveRecord associations" do
    it { expect( line_item ).to belong_to :order }

    it { expect( line_item ).to belong_to :product }

    it { expect( line_item ).to belong_to :cart }
  end

  describe "public instance methods" do
    context "responds to its methods" do
      it { expect( line_item ).to respond_to(:total_price) }
    end

    context "executes methods correctly" do
      context "total_price" do
        it "multiplies price by quantity"  do
          product = create(:product, id: 1, price: 20)
          line_item1 = create(:carted_line_item, quantity: 2)
          expect( line_item1.total_price ).== 69.9
        end
      end
    end
  end
end
