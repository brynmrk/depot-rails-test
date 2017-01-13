require 'rails_helper'

describe UsersController, :type => :controller do
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
      it "should create new user" do
        expect {
          create( :user, name: 'Test User2', email: 'testuser1@email.com', password: '12345678', password_confirmation: '12345678' )
        }.to change(User, :count).by(1)
      end
    end

    describe "invalid attributes" do
      describe "new user" do
        it "should show error/s because no name" do
          expect {
            create( :user, name: '', email: 'testuser2@email.com', password: '12345678', password_confirmation: '12345678' )
          }.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Name can't be blank")
        end

        it "should show error/s because duplicate name" do
          expect {
            create(:user, name: 'Test User', email: 'testemail3@email.com', password: '12345678', password_confirmation: '12345678' )
          }.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Name has already been taken")
        end

        it "should show error/s because invalid email" do
          expect {
            create( :user, name: 'Test User1', email: '', password: '12345678', password_confirmation: '12345678' )
          }.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Email can't be blank")
        end

        it "should show error/s because duplicate email" do
          expect {
            create( :user, name: 'Test User2', email: 'testuser@email.com', password: '12345678', password_confirmation: '12345678' )
          }.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Email has already been taken")
        end

        describe "password error" do
          it "should show error/s because invalid password/password_confirmation" do
            expect {
              create( :user, name: 'Test User3', email: 'testuser5@email.com', password: '12345678', password_confirmation: 'cGh7WFaRx' )
            }.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Password confirmation doesn't match Password")
          end

          it "should show error/s because no password/password_confirmation" do
            expect {
              create( :user, name: 'Test User4', email: 'testuser5@email.com', password: '', password_confirmation: '' )
            }.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Password can't be blank")
          end
        end
      end
    end
  end
end
