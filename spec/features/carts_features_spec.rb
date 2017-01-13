require 'rails_helper'

describe 'Cart', type: :feature, js: true do
  describe "when not logged in" do
    it "redirect to login" do
      visit carts_path
      page.current_path == users_sign_in_path
    end
  end

  describe "when logged in" do
    before(:each) do
      FactoryGirl.reload
      create(:user)
      create_list(:product, 20)
      visit users_sign_in_path
      fill_in 'Email', with: 'testuser@email.com'
      fill_in 'Password', with: '12345678'
      click_button 'Login'
      visit store_path
    end

    describe 'User go to carts' do
      it "match the current path to store path" do
        page.current_path == store_path
      end
    end

    describe "creating a new cart" do
      before(:each) do
        visit store_path
        click_button 'btn_add_1'
        click_button 'btn_add_2'
        click_button 'btn_add_3'
      end

      it "shows the new cart page" do
        page.current_path == store_path
      end

      it "creates a new cart" do
        page.has_css? '#current_item'
      end
    end

    describe "show cart" do
      before(:each) do
        click_button 'btn_add_1'
        click_button 'btn_add_2'
        click_button 'btn_add_3'
        visit carts_path
        click_link 'btn_show_1'
      end

      it "shows the page of a specific cart" do
        page.current_path == cart_path(1)
      end

      it "goes back to the cart page" do
        page.current_path == cart_path(1)
        click_link 'Back'
        page.current_path == carts_path
      end
    end

    describe "delete cart" do
      before(:each) do
        click_button 'btn_add_1'
        click_button 'btn_add_2'
        click_button 'btn_add_3'
        visit carts_path
      end

      it "delete a specific cart" do
        click_link 'btn_del_1'
        page.accept_alert
        page.current_path == carts_path
      end
    end
  end
end
