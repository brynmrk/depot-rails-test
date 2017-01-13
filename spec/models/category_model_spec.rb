require 'rails_helper.rb'

describe Category do
  let(:category) { create(:category) }

  it { expect( create(:category) ).to be_valid }

  describe "ActiveModel validations" do
    it { expect( category ).to validate_presence_of :name }

    it { expect( category ).to validate_presence_of :description }

    it { expect( category ).to validate_uniqueness_of :name }
  end

  describe "ActiveRecord associations" do
    it { expect( category ).to have_many :products }
  end
end
