require 'rails_helper.rb'

describe Product do
  let(:product) { create(:product) }

  it { expect( create(:product) ).to be_valid }

  describe "ActiveModel validations" do
    it { expect( product ).to validate_presence_of :title }

    it { expect( product ).to validate_presence_of :description }

    it { expect( product ).to validate_presence_of :image_url }

    it { expect( product ).to validate_presence_of :category_id }

    it { expect( product ).to validate_numericality_of(:price).is_greater_than_or_equal_to 0.01 }

    it { expect( product ).to validate_uniqueness_of :title }

    it { expect( product ).to allow_value('*.gif, *.jpg, *.png').for :image_url }
  end

  describe "ActiveRecord associations" do
    it { expect( product ).to belong_to :category }

    it { expect( product ).to have_many :line_items }

    it { expect( product ).to have_many(:orders).through :line_items }
  end

  context "callbacks" do
    it { expect( product ).to callback(:ensure_not_referenced_by_any_line_item).before :destroy }
  end

  describe "public instance methods" do
    context "responds to its methods" do
      before(:each) { @product = create(:product, title: 'hehe') }

      it { expect( Product ).to respond_to :latest }
    end

    context "executes methods correctly" do
      context "#latest" do
        it { expect( Product.latest ).to eq @product }
      end
    end
  end
end
