require 'rails_helper.rb'

describe StoreController, :type => :controller do
  describe "GET #index" do
    it { expect( get :index ).to have_http_status 200 }

    it { expect( get :index ).to render_template :index }

    it { expect( get :index, search: '', category: '' ).to have_http_status 200 }

    it { expect( get :index, search: '', category: 'Fiction' ).to have_http_status 200 }

    it { expect( get :index, search: 'CoffeeScript', category: '' ).to have_http_status 200 }

    it { expect( get :index, search: 'CoffeeScript', category: 'Fiction' ).to have_http_status 200 }

    it { expect( get :index, :search => { category_id: 1 } ).to have_http_status 200 }
  end

end
