require 'rails_helper.rb'

describe ProductsController, :type => :controller do
  FactoryGirl.reload
  let(:user) { create(:user) }
  before(:each) { sign_in user }

  describe "GET #index" do
    describe "authorized acces" do
      it { expect( get :index ).to have_http_status 200 }

      it { expect( get :index ).to render_template :index }
    end

    describe "unauthorized access" do
      before(:each) { sign_out user }

      it { expect( sign_in 'bryan.fajutag@adish.co.jp', '12345678' ).to_not have_http_status 302 }

      it { expect( sign_in '', '12345678' ).to_not have_http_status 302 }

      it { expect( get :index ).to redirect_to users_sign_in_path }
    end
  end

  describe "GET #new" do
    it { expect( get :new ).to have_http_status 200 }

    it { expect( get :new ).to render_template :new }
  end

  describe "POST #new" do
    describe "valid attributes" do
      it { expect( post :create, product: attributes_for(:product, title: 'helo world', description: 'This is a description', image_url: 'cs.jpg', price: 90, category_id: 1) ).to redirect_to products_path }
    end

    describe "invalid attributes" do
      describe "new product" do
        before(:each) { create( :product, title: 'Book 1' ) }

        it "should show error/s because title was already taken" do
          expect {
            create( :product, title: 'Book 1', description: 'This is updated through FG', image_url: 'cs.jpg', price: 85, category_id: 2 )
          }.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Title has already been taken")
        end

        it "should show error/s because invalid image_url" do
          expect {
            create( :product, title: 'CoffeeScript', description: 'This is updated through FG', image_url: 'cs.jp3', price: 85, category_id: 2 )
          }.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Image url must be a URL for GIF, JPG or PNG image.")
        end

        it "should show error/s because invalid price" do
          expect {
            create( :product, title: 'CoffeeScript1', description: 'This is updated through FG', image_url: 'cs.jpg', price: -85, category_id: 2 )
          }.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Price must be greater than or equal to 0.01")
        end
      end
    end
  end

  describe "PATCH #edit" do
    before( :each ) { @product1 = create( :product ) }

    describe "render :edit" do
      it { expect( get :edit, id: @product1 ).to have_http_status 200 }

      it { expect( get :edit, id: @product1 ).to render_template :edit }
    end

    describe "valid attributes" do
      before(:each) do
        put :update, id: @product1, product: attributes_for( :product, title: 'ProductFromFG', description: 'This is updated through FG', image_url: 'cs1.jpg', price: 95, category_id: 2 )
        @product1.reload
      end

      it { expect( @product1.title ).to eq( 'ProductFromFG' ) }

      it { expect( @product1.description ).to eq( 'This is updated through FG' ) }

      it { expect( @product1.image_url ).to eq( 'cs1.jpg' ) }

      it { expect( @product1.price ).to eq( 95 ) }

      it { expect( @product1.category_id ).to eq( 2 ) }
    end

    describe "invalid attributes" do
      describe "update product title" do
        it "should show error/s because title is already taken" do
          create(:product, title: 'CoffeeScript')
          put :update, id: @product1, product: attributes_for( :product, title: 'CoffeeScript' )
          expect( response ).to have_http_status 200
        end

        it "should show error/s because no title" do
          put :update, id: @product1, product: attributes_for( :product, title: '' )
          expect( response ).to have_http_status 200
        end
      end

      describe "update product description" do
        it "should show error/s because invalid description" do
          put :update, id: @product1, product: attributes_for( :product, description: '' )
          expect( response ).to have_http_status 200
        end
      end

      describe "update product image_url" do
        it "should show error/s because invalid image_url" do
          put :update, id: @product1, product: attributes_for( :product, image_url: 'testing.jpg1' )
          expect( response ).to have_http_status 200
        end
      end

      describe "update product price" do
        it "should show error/s because invalid price" do
          put :update, id: @product1, product: attributes_for( :product, price: -5 )
          expect( response ).to have_http_status 200
        end
      end
    end
  end

  describe "DELETE #destroy" do
    before(:each) { @product1 = create(:product) }

    it "should destroy a product" do
      expect {
        delete :destroy, id: @product1, :product => {:title => @product1.title}
      }.to change(Product, :count).by(-1)
    end

    it { expect( delete :destroy, id: @product1, :product => {:title => @product1.title} ).to redirect_to products_path }
  end
end
