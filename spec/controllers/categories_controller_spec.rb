require 'rails_helper.rb'

describe CategoriesController, :type => :controller do
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
    it { expect( get :new ).to have_http_status 200 }

    it { expect( get :new ).to render_template :new }
  end

  describe "POST #new" do
    describe "valid attributes" do
      it { expect{ create(:category) }.to change(Category, :count).by(1) }
    end

    describe "invalid attributes" do
      before(:each) { @category1 = create( :category ) }

      describe "new category" do
        it "should show error/s because name was already taken" do
          create( :category, name: 'Fiction', description: 'This is some description.' )

          put :update, id: @category1, category: attributes_for( :category, name: 'Fiction' )
          expect( response ).to have_http_status 200
        end
      end
    end
  end

  describe "PATCH #edit" do
    before( :each )  { @category1 = create( :category ) }

    describe "valid attributes" do
      before(:each) do
        put :update, id: @category1, category: attributes_for( :category, name: 'CategoryFromFG', description: 'This is some description.' )
        @category1.reload
      end

      it { expect( @category1.name ).to eq( 'CategoryFromFG' ) }

      it { expect( @category1.description ).to eq( 'This is some description.' ) }
    end

    describe "invalid attributes" do
      before(:each) { create( :category, name: 'CoffeeScript' ) }

      describe "update category name" do
        it "should show error/s because name is already taken" do
          put :update, id: @category1, category: attributes_for( :category, name: 'CoffeeScript' )
          expect( response ).to have_http_status 200
        end

        it "should show error/s because no name" do
          put :update, id: @category1, category: attributes_for( :category, name: '' )
          expect( response ).to have_http_status 200
        end
      end

      describe "update category description" do
        it "should show error/s because no description" do
          put :update, id: @category1, category: attributes_for( :category, description: '' )
          expect( response ).to have_http_status 200
        end
      end
    end
  end

  describe "DELETE #destroy" do
    before(:each) do
      @category1 = create(:category)
    end

    it "should destroy a category" do
      expect {
        delete :destroy, id: @category1, :category => {:name => @category1.name}
      }.to change(Category, :count).by(-1)
    end

    it "should redirect after deleting" do
      delete :destroy, id: @category1, :category => {:name => @category1.name}
      expect(response).to redirect_to(categories_path)
    end
  end
end
