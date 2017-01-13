require 'rails_helper.rb'

describe User do
  let(:user) { create(:user) }

  it { expect( create(:user) ).to be_valid }

  describe "ActiveModel validations" do
    it { expect( user ).to validate_presence_of :name }

    it { expect( user ).to validate_uniqueness_of :name }
  end

  context "callbacks" do
    it { expect( user ).to callback(:ensure_an_admin_remains).after(:destroy) }
  end

  # describe "public instance methods" do
  #   context "responds to its methods" do
  #     it { expect( user ).to respond_to :ensure_an_admin_remains }
  #   end
  #
  #   context "executes methods correctly" do
  #     context "#ensure_an_admin_remains" do
  #       it "does what its supposed to" do
  #         expect( user.ensure_an_admin_remains ).to eq ''
  #       end
  #     end
  #   end
  # end
end
