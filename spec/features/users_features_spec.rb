require 'rails_helper'

describe 'User', type: :feature, js: true do
  describe "when not logged in" do
    it "redirect to login" do
      visit users_path
      page.current_path == users_sign_in_path
    end
  end

  describe "when logged in" do
    before(:each) do
      FactoryGirl.reload
      create(:user)
      create(:user, name: 'User to delete', email: 'deleteuser@email.com', password: '12345678', password_confirmation: '12345678')
      create_list(:product, 20)
      visit users_sign_in_path
      fill_in 'Email', with: 'testuser@email.com'
      fill_in 'Password', with: '12345678'
      click_button 'Login'
      visit users_path
    end

    describe 'User go to users' do
      it "match the current path to users path" do
        page.current_path == users_path
      end
    end

    describe "edit product" do
      before(:each) { click_link 'btn_edit_1' }

      it "shows the edit page of a specific product" do
        page.current_path == edit_user_path(1)
      end

      it "change the product title" do
        fill_in 'Name', with: 'Test User of the User'
        fill_in 'Password', with: '12345678'
        fill_in 'Confirm Password', with: '12345678'
        click_button 'Update User'
        page.current_path == users_path
      end

      it "change the product description" do
        fill_in 'Email', with: 'testuserforuser@email.com'
        fill_in 'Password', with: '12345678'
        fill_in 'Confirm Password', with: '12345678'
        click_button 'Update User'
        page.current_path == users_path
      end

      it "goes back to the  product path" do
        click_link 'Back'
        page.current_path == users_path
      end
    end

    describe "delete user" do
      it "delete a specific user" do
        click_link 'btn_del_2'
        page.accept_alert
        page.current_path == users_path
      end
    end
  end
end
