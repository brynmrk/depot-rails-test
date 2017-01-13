# require 'rails_helper.rb'
#
# describe StoreController, :type => :controller do
#
#   describe "GET #index" do
#     it "responds successfully with an HTTP 200 status code" do
#       get :index
#       expect(response).to be_success
#       expect(response).to have_http_status(200)
#     end
#
#     it "renders the index template" do
#       get :index
#       expect(response).to render_template("index")
#     end
#
#     it "shows all the product in the index" do
#       post :index, search: '', category: ''
#       expect(response).to be_success
#     end
#
#     it "shows all the product with specific category in the index" do
#       post :index, search: '', category: 'Fiction'
#       expect(response).to be_success
#     end
#
#     it "shows the product with specific name in the index" do
#       post :index, search: 'CoffeeScript', category: ''
#       expect(response).to be_success
#     end
#
#     it "shows the product with specific name and specific category in the index" do
#       post :index, search: 'CoffeeScript', category: 'Fiction'
#       expect(response).to be_success
#     end
#   end
# end
