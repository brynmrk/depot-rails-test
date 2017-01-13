require 'rails_helper.rb'

describe Order do
  let(:order) { create(:order) }

  it { expect( create(:order) ).to be_valid }

  describe "ActiveModel validations" do
    it { expect( order ).to validate_presence_of :name }

    it { expect( order ).to validate_presence_of :address }

    it { expect( order ).to validate_presence_of :email }

    it { expect( order ).to validate_inclusion_of(:pay_type).in_array( ["Check", "Credit card", "Purchase order"] ) }
  end

  describe "ActiveRecord associations" do
    it { expect( order ).to have_many(:line_items).dependent :destroy }
  end

  describe "public instance methods" do
    before(:each) { @cart = create(:cart, line_items: [create(:carted_line_item)]) }

    context "responds to its methods" do
      it { expect( order ).to respond_to :add_line_items_from_cart }
    end

    context "executes methods correctly" do
      context "add_line_items_from_cart" do
        it { expect( order.add_line_items_from_cart( @cart ) ).to eq @cart.line_items }
      end
    end
  end
end
