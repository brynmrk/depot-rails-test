require 'rails_helper'

describe 'Order', type: :feature, js: true do
  describe "when not logged in" do
    it "redirect to login" do
      visit orders_path
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

    describe 'User go to order' do
      it "match the current path to store path" do
        page.current_path == store_path
      end
    end

    describe "creating a new order" do
      before(:each) do
        click_button 'btn_add_1'
        click_button 'btn_add_2'
        click_button 'btn_add_3'
        click_button 'Checkout'
      end

      it "shows the new orders page" do
        page.current_path == new_order_path
      end

      it "goes back to the orders page" do
        click_link 'Back'
        page.current_path == orders_path
      end

      it "creates a invalid name" do
        fill_in 'Name', with: ''
        fill_in 'Email', with: 'testuser@email.com'
        fill_in 'Address', with: 'Address for the test order'
        select 'Check', from: 'order_pay_type'
        click_button 'Place Order'
        page.current_path == new_order_path
      end

      it "create a product with invalid email" do
        fill_in 'Name', with: 'Test User'
        fill_in 'Email', with: 'testuser@com'
        fill_in 'Address', with: 'Address for the test order'
        select 'Check', from: 'order_pay_type'
        click_button 'Place Order'
        page.current_path == new_order_path
      end

      it "create a product with invalid address" do
        fill_in 'Name', with: 'Test User'
        fill_in 'Email', with: 'testuser@email.com'
        fill_in 'Address', with: ''
        select 'Check', from: 'order_pay_type'
        click_button 'Place Order'
        page.current_path == new_order_path
      end

      it "creates a new order" do
        fill_in 'Name', with: 'Test User'
        fill_in 'Email', with: 'testuser@email.com'
        fill_in 'Address', with: 'Address for the test order'
        select 'Check', from: 'order_pay_type'
        click_button 'Place Order'
        page.current_path == new_order_path
      end
    end

    describe "edit order" do
      before(:each) do
        click_button 'btn_add_1'
        click_button 'btn_add_2'
        click_button 'btn_add_3'
        click_button 'Checkout'
        fill_in 'Name', with: 'Test User'
        fill_in 'Email', with: 'testuser@email.com'
        fill_in 'Address', with: 'Address for the test order'
        select 'Check', from: 'order_pay_type'
        click_button 'Place Order'
        visit edit_order_path(1)
      end

      it "shows the edit page of a specific product" do
        page.current_path == edit_order_path(1)
      end

      it "change the order name" do
        fill_in 'Name', with: 'Test Order 2'
        click_button 'Place Order'
        page.current_path == orders_path
      end

      it "change the order email" do
        fill_in 'Email', with: 'testuser2@email.com'
        click_button 'Place Order'
        page.current_path == orders_path
      end

      it "change the order address" do
        fill_in 'Address', with: 'This is the updated address of the order'
        click_button 'Place Order'
        page.current_path == orders_path
      end

      it "change the order pay_type" do
        select 'Credit card', from: 'order_pay_type'
        click_button 'Place Order'
        page.current_path == orders_path
      end

      it "goes back to the  orders path" do
        click_link 'Back'
        page.current_path == orders_path
      end
    end

    describe "delete product" do
      before(:each) do
        click_button 'btn_add_1'
        click_button 'btn_add_2'
        click_button 'btn_add_3'
        click_button 'Checkout'
        fill_in 'Name', with: 'Test User'
        fill_in 'Email', with: 'testuser@email.com'
        fill_in 'Address', with: 'Address for the test order'
        select 'Check', from: 'order_pay_type'
        click_button 'Place Order'
        visit orders_path
      end

      it "delete a specific product" do
        click_link 'btn_del_1'
        page.accept_alert
        page.current_path == orders_path
      end
    end
  end
end
