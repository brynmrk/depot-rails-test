require 'rails_helper'

describe 'Store', type: :feature do
  describe "search functions" do
    before(:each) do
      FactoryGirl.reload
      create_list(:product, 20)
    end

    it "search with just title" do
      visit store_path
      fill_in 'search_query', with: 'Book'
      click_button 'Search'
      # puts "#{page.methods}"
    end
  end

  describe "when not logged in" do
    it "redirect to login" do
      visit store_path
      page.current_path == store_path
    end
  end

  describe "when logged in" do
    before(:each) do
      FactoryGirl.reload
      create(:user)
      create_list(:product, 20)
      visit store_path
    end

    describe 'User go to store' do
      it "match the current path to store url" do
        page.current_path == store_path
      end
    end

    describe 'Add product to cart', js: true do
      it "click the first product and display to cart" do
        click_button 'btn_add_1'
        page.has_css? '#current_item'
      end

      it "add a product and click the button checkout" do
        click_button 'btn_add_1'

        click_button 'Checkout'
        page.current_path == new_order_path
      end

      it "click the second product and display to cart" do
        click_button 'btn_add_2'
        page.has_css? '#current_item'
      end

      it "add a product and empty the cart" do
        click_button 'btn_add_2'

        click_link 'Empty Cart'
        page.accept_alert
        page.current_path == store_path
      end

      it "click the first product and add quantity" do
        click_button 'btn_add_1'

        click_button '+'
        page.has_css? '#current_item', text: '2x'
      end

      it "click the first product and decrease quantity" do
        click_button 'btn_add_1'
        click_button '+'
        click_button '-'
        page.has_css? '#current_item', text: '1x'
      end

      it "click the first product and remove cart if quantity is 1" do
        click_button 'btn_add_1'

        click_button '-'
        expect(page).to have_selector('#cart', visible: false)
      end

      it "add many product" do
        click_button 'btn_add_1'
        click_button 'btn_add_2'

        page.has_selector? 'ul', count: 3
      end
    end

    describe "User go to login page", js: true do
      before(:each) { click_link 'Login' }

      describe "not logged in" do
        it "match the current path to login page" do
          page.current_path == users_sign_in_path
        end

        it "sign in with incorrect email" do
          fill_in 'Email', with: 'testuser1@email.com'
          fill_in 'Password', with: '12345678'
          click_button 'Login'
          page.current_path == users_sign_in_path
        end

        it "sign in with incorrect password" do
          fill_in 'Email', with: 'testuser@email.com'
          fill_in 'Password', with: '123456781'
          click_button 'Login'
          page.current_path == users_sign_in_path
        end

        it "sign in with correct details" do
          fill_in 'Email', with: 'testuser@email.com'
          fill_in 'Password', with: '12345678'
          click_button 'Login'
          page.current_path == store_path
        end
      end
    end

    describe "click links available for logged in users", js: true do
      before(:each) do
        click_link 'Login'
        fill_in 'Email', with: 'testuser@email.com'
        fill_in 'Password', with: '12345678'
        click_button 'Login'
        click_link 'Links'
      end

      it "opens the category link" do
        click_link 'Category'
        page.current_path == categories_path
      end

      it "opens the product link" do
        click_link 'Products'
        page.current_path == products_path
      end

      it "opens the cart link" do
        click_link 'Carts'
        page.current_path == carts_path
      end

      it "opens the order link" do
        click_link 'Orders'
        page.current_path == orders_path
      end

      it "opens the line item link" do
        click_link 'Line Item'
        page.current_path == line_items_path
      end

      it "opens the user link" do
        click_link 'Users'
        page.current_path == users_path
      end
    end
  end
end
