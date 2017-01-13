require 'rails_helper'

describe 'LineItem', type: :feature, js: true do
  describe "when not logged in" do
    it "redirect to login" do
      visit line_items_path
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
      visit line_items_path
    end

    describe 'User go to line items' do
      it "match the current path to line items path" do
        page.current_path == line_items_path
      end
    end

    describe "creating a new line items" do
      before(:each) { visit store_path }

      it "shows the store page to create a line item/s" do
        page.current_path == store_path
      end

      it "creates a new line item/s" do
        click_button 'btn_add_1'
        click_button 'btn_add_2'
        click_button 'btn_add_3'
        visit line_items_path
        page.should have_selector('table tr', count: 4)
      end
    end
  end
end
