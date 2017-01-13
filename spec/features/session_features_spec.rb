require 'rails_helper'

describe 'Session', type: :feature, js: true do
  before(:each) do
    create(:user)
    visit users_sign_in_path
  end

  describe "user goes to login page" do
    it "match the current path to store path" do
      page.current_path == users_path
    end
  end

  describe "user logged in" do
    it "user enter correct details" do
      fill_in 'Email', with: 'testuser@email.com'
      fill_in 'Password', with: '12345678'
      click_button 'Login'
      page.current_path == store_path
    end
  end

  describe "user signed up" do
    it "user signed up for a new account" do
      click_link 'Sign up'
      page.current_path == new_user_registration_path
    end
  end

  describe "user logged out" do
    it "user enter correct details and logout" do
      fill_in 'Email', with: 'testuser@email.com'
      fill_in 'Password', with: '12345678'
      click_button 'Login'
      click_link 'Logout'
      page.current_path == store_path
    end
  end

  describe "user forgot password" do
    it "forgot password request" do
      click_link 'Forgot your password?'
      page.current_path == new_user_password_path
    end
  end
end
