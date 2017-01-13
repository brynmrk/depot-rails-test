require 'rails_helper'

describe Cart do
  before(:each) { @cart = create(:cart, line_items: [create(:carted_line_item)]) }

  it { expect( create(:cart) ).to be_valid }

  describe "ActiveRecord associations" do
    it { expect( @cart ).to have_many(:line_items).dependent :destroy }
  end

  describe "public instance methods" do
    context "responds to its methods" do

      it { expect( @cart ).to respond_to :total_price }

      it { expect( @cart ).to respond_to :increment_product }

      it { expect( @cart ).to respond_to :decrement_product }
    end

    context "executes methods correctly" do
      context "#total_price" do
        it "does what its supposed to" do
          expect( @cart.total_price ).to eq 34.95
        end
      end

      context "#increment_product" do
        it "add quantity when same product" do
          expect {
            @cart.increment_product 1
            @cart.save
          }.to change(LineItem, :count).by(0)
        end

        it "add to cart when different product" do
          product10 = create(:product, id:10, title: 'hello')
          expect {
            @cart.increment_product product10
            @cart.save
          }.to change(LineItem, :count).by(1)
        end
      end

      context "#decrement_product" do
        it "decrease quantity" do
          expect {
            @cart.decrement_product 1
            @cart.save
          }.to change(LineItem, :count).by(-1)
        end
      end
    end
  end
end
