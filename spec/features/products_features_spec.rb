require 'rails_helper'

describe 'Product', type: :feature, js: true do
  describe "when not logged in" do
    it "redirect to login" do
      visit products_path
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
      visit products_path
    end

    describe 'User go to products' do
      it "match the current path to products path" do
        page.current_path == products_path
      end
    end

    describe "creating a new product" do
      before(:each) { visit new_product_path }

      it "shows the new products page" do
        page.current_path == new_product_path
      end

      it "goes back to the product page" do
        click_link 'Back'
        page.current_path == products_path
      end

      it "creates a duplicate product title" do
        fill_in 'Title', with: 'Book 1'
        fill_in 'Description', with: 'Some description that may help the reader understand what the product is for.'
        select 'Category 3', from: 'product_category_id'
        fill_in 'Image Url', with: 'cs.jpg'
        fill_in 'Price', with: 20
        click_button 'Create Product'
        page.current_path == new_product_path
      end

      it "create a product with invalid price" do
        fill_in 'Title', with: 'Product'
        fill_in 'Description', with: 'Some description that may help the reader understand what the product is for.'
        select 'Category 4', from: 'product_category_id'
        fill_in 'Image Url', with: 'cs.jpg'
        fill_in 'Price', with: -100
        click_button 'Create Product'
        page.current_path == new_product_path
      end

      it "create a product with invalid image url" do
        fill_in 'Title', with: 'Product'
        fill_in 'Description', with: 'Some description that may help the reader understand what the product is for.'
        select 'Category 5', from: 'product_category_id'
        fill_in 'Image Url', with: 'cs.jp3'
        fill_in 'Price', with: 20
        click_button 'Create Product'
        page.current_path == new_product_path
      end

      it "creates a new product" do
        fill_in 'Title', with: 'Product for Something Great'
        fill_in 'Description', with: 'Some description that may help the reader understand what the product is for.'
        select 'Category 6', from: 'product_category_id'
        fill_in 'Image Url', with: 'cs.jpg'
        fill_in 'Price', with: 20
        click_button 'Create Product'
        page.current_path == products_path
      end
    end

    describe "show product" do
      before(:each) { click_link 'btn_show_1' }

      it "shows the page of a specific product" do
        page.current_path == product_path(1)
      end

      it "goes back to the product page" do
        page.current_path == product_path(1)
        click_link 'Back'
        page.current_path == products_path
      end

      it "goes to the edit product page" do
        page.current_path == product_path(1)
        click_link 'Edit'
        page.current_path == edit_product_path(1)
      end
    end

    describe "edit product" do
      before(:each) { click_link 'btn_edit_1' }

      it "shows the edit page of a specific product" do
        page.current_path == edit_product_path(1)
      end

      it "change the product title" do
        fill_in 'Title', with: 'Test Product Edit'
        click_button 'Update Product'
        page.current_path == products_path
      end

      it "change the product description" do
        fill_in 'Description', with: 'Some description that may help the reader understand what the product is for.'
        click_button 'Update Product'
        page.current_path == products_path
      end

      it "goes back to the  product path" do
        click_link 'Back'
        page.current_path == products_path
      end

      it "shows the specific product" do
        click_link 'Show'
        page.current_path == edit_product_path(1)
      end
    end

    describe "delete product" do
      it "delete a specific product" do
        click_link 'btn_del_1'
        page.accept_alert
        page.current_path == products_path
      end
    end
  end
end
