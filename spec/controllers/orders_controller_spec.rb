require 'rails_helper.rb'

describe OrdersController, :type => :controller do
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

  describe "GET #new" do
    describe "when no cart is found" do
      it { expect( get :new ).to have_http_status 302 }

      it { expect( get :new ).to redirect_to store_url }
    end

    describe "when a cart is found" do
      before :each do
        cart = create(:cart, line_items: [create(:carted_line_item)])
        @request.session[:cart_id] = cart.id
      end

      it { expect( get :new ).to have_http_status 200 }

      it { expect( get :new ).to render_template :new }
    end
  end

  describe "POST #new" do
    before :each do
      cart = create(:cart, line_items: [create(:carted_line_item)])
      @request.session[:cart_id] = cart.id
    end

    describe "when no cart is found" do
      it "should redirect to store when no cart" do
        @request.session[:cart_id] = nil
        expect( get :new ).to redirect_to store_url
      end
    end

    describe "when a cart is found" do
      before :each do
        cart = create(:cart, line_items: [create(:carted_line_item)])
        @request.session[:cart_id] = cart.id
      end

      describe "valid attributes" do
        it "should create a new order" do
          expect{
            create(:order)
          }.to change(Order, :count).by(1)
        end
      end

      describe "invalid attributes" do
        describe "new order" do
          it "should show error/s because invalid name" do
            expect {
              create( :order, name: '', email: 'firsttestorder@email.com', address: 'Test St Brgy. Test, Test City Test', pay_type: 'Check' )
            }.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Name can't be blank")
          end

          it "should show error/s because invalid email" do
            expect {
              create( :order, name: 'Third Test Order', email: '', address: 'Test St Brgy. Test, Test City Test', pay_type: 'Credit card' )
            }.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Email can't be blank")
          end

          it "should show error/s because invalid address" do
            expect {
              create( :order, name: 'Fourth Test Order', email: 'firsttestorder@email.com', address: '', pay_type: 'Purchase order' )
            }.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Address can't be blank")
          end

          it "should show error/s because invalid payment type" do
            expect {
              create( :order, name: 'Fourth Test Order', email: 'firsttestorder@email.com', address: 'Test St Brgy. Test, Test City Test', pay_type: 'Some Payment' )
            }.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Pay type is not included in the list")
          end
        end
      end
    end
  end

  describe "PATCH #edit" do
    before :each do
      cart = create(:cart, line_items: [create(:carted_line_item)])
      @request.session[:cart_id] = cart.id
      @order = create(:order)
    end

    describe "render :edit" do
      it { expect( get :edit, id: @order ).to have_http_status 200 }

      it { expect( get :edit, id: @order ).to render_template :edit }
    end

    describe "valid attributes" do
      before(:each) do
        put :update, id: @order, order: attributes_for( :order, name: 'Test Order', address: 'This address is for the Test Order', email: 'testorder@order.com', pay_type: 'Check' )
        @order.reload
      end

      it { expect( @order.name ).to eq( 'Test Order' ) }

      it { expect( @order.address ).to eq( 'This address is for the Test Order' ) }

      it { expect( @order.email ).to eq( 'testorder@order.com' ) }

      it { expect( @order.pay_type ).to eq( 'Check' ) }
    end

    describe "invalid attributes" do
      it "should show error/s because no name" do
        expect {
          create( :order, name: '', address: 'This address is for Test Order', email: 'testorder@order.com', pay_type: 'Check' )
        }.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Name can't be blank")
      end

      it "should show error/s because invalid address" do
        expect {
          create( :order, name: 'Test Order', address: '', email: 'testorder@order.com', pay_type: 'Check' )
        }.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Address can't be blank")
      end

      it "should show error/s because invalid email" do
        expect {
          create( :order, name: 'Test Order', address: 'This address is for Test Order', email: '', pay_type: 'Check' )
        }.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Email can't be blank")
      end

      it "should show error/s because invalid pay_type" do
        expect {
          create( :order, name: 'Test Order', address: 'This address is for Test Order', email: 'testorder@order.com', pay_type: '' )
        }.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Pay type is not included in the list")
      end
    end
  end

  describe "DELETE #destroy" do
    before(:each) { @order = create(:order) }

    it "should destroy a product" do
      expect {
        delete :destroy, id: @order, :order => {:name => @order.name}
      }.to change(Order, :count).by(-1)
    end

    it { expect( delete :destroy, id: @order, :order => {:name => @order.name} ).to redirect_to orders_path }
  end
end
