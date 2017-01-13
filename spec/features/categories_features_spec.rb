require 'rails_helper'

describe 'Category', type: :feature, js: true do
  describe "when not logged in" do
    it "redirect to login" do
      visit categories_path
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
      visit categories_path
    end

    describe 'User go to category' do
      it "match the current path to categories path" do
        page.current_path == categories_path
      end
    end

    describe "creating a new category" do
      before(:each) { visit new_category_path }

      it "shows the new categories page" do
        page.current_path == new_category_path
      end

      it "goes back to the categories page" do
        click_link 'Back'
        page.current_path == categories_path
      end

      it "creates a duplicate category name" do
        fill_in 'Name', with: 'Category 121'
        fill_in 'Description', with: 'Some description that may help the reader understand what the category is for.'
        click_button 'Create Category'
        page.current_path == new_category_path
      end

      it "creates a new category" do
        fill_in 'Name', with: 'Autobiography'
        fill_in 'Description', with: 'Some description that may help the reader understand what the category is for.'
        click_button 'Create Category'
        page.current_path == categories_path
      end
    end

    describe "show category" do
      before(:each) { click_link 'btn_show_1' }

      it "shows the page of a specific category" do
        page.current_path == category_path(1)
      end

      it "goes back to the categories page" do
        page.current_path == category_path(1)
        click_link 'Back'
        page.current_path == categories_path
      end

      it "goes to the edit category page" do
        page.current_path == category_path(1)
        click_link 'Edit'
        page.current_path == edit_category_path(1)
      end
    end

    describe "edit category" do
      before(:each) { click_link 'btn_edit_1' }

      it "shows the edit page of a specific category" do
        page.current_path == edit_category_path(1)
      end

      it "change the category name" do
        fill_in 'Name', with: 'Test Category Edit'
        click_button 'Update Category'
        page.current_path == categories_path
      end

      it "change the category description" do
        fill_in 'Description', with: 'Some description that may help the reader understand what the category is for.'
        click_button 'Update Category'
        page.current_path == categories_path
      end

      it "goes back to the  categories path" do
        click_link 'Back'
        page.current_path == categories_path
      end

      it "shows the specific category" do
        click_link 'Show'
        page.current_path == edit_category_path(1)
      end
    end

    describe "delete category" do
      it "delete a specific category" do
        click_link 'btn_del_1'
        page.accept_alert
        page.current_path == categories_path
      end
    end
  end
end
