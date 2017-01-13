require 'rails_helper'

describe CartsController, :type => :controller do
  FactoryGirl.reload
  let(:user) { create(:user) }
  before(:each) { sign_in user }

  describe "GET #index" do
    before(:each) { get :index }

    describe "authorized acces" do
      it { expect(response).to have_http_status 200 }
      it { expect(response).to render_template :index }
    end

    describe "unauthorized access" do
      before(:each) { sign_out user }

      it { expect( sign_in 'bryan.fajutag@adish.co.jp', '12345678' ).to_not have_http_status 302 }

      it { expect( sign_in '', '12345678' ).to_not have_http_status 302 }

      it { expect( get :index ).to redirect_to users_sign_in_path }
    end
  end

  describe "DELETE #destroy" do
    before(:each) { @cart = create(:cart) }

    it "should destroy a cart" do
      @request.session[:cart_id] = @cart.id
      expect {
        delete :destroy, id: @cart
      }.to change(Cart, :count).by(-1)
    end

    it "should redirect" do
      @request.session[:cart_id] = @cart.id
      expect( delete :destroy, id: @cart ).to redirect_to store_path
    end
  end
end
