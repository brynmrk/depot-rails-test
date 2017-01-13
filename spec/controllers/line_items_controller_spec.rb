require 'rails_helper.rb'

describe LineItemsController, :type => :controller do
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

  describe "POST #create" do
    describe "when cart is empty" do
      it "should add product to line_item" do
        expect {
          post :create, { product_id: create(:product), type: 'increment' }
        }.to change(LineItem, :count).by(1)
      end
    end

    describe "when cart is not empty" do
      before(:each) do
        create(:carted_line_item, product_id: 1)
        create(:product, id: 1)
      end

      describe "same product" do
        it "should add product quantity" do
          expect {
            post :create, { product_id: 1, type: 'increment' }
          }.to change{ LineItem.last.quantity }.by(1)
        end

        it "should remove product to line_item" do
          expect {
            post :create, { product_id: 1, type: 'decrement' }
          }.to change(LineItem, :count).by(-1)
        end
      end

      describe "different product" do
        it "should add product to line_item" do
          expect {
            post :create, { product_id: create(:product, title: 'Hello World'), type: 'increment' }
          }.to change(LineItem, :count).by(1)
        end
      end
    end
  end
end
