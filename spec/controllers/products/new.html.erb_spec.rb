# require 'rails_helper.rb'
#
# describe ProductsController, :type => :controller do
#
#   describe "GET #new" do
#     it "responds successfully with an HTTP 200 status code" do
#       sign_in User.find(1)
#       get :new
#       expect(response).to be_success
#       expect(response).to have_http_status(200)
#     end
#
#     it "renders the new template" do
#       sign_in User.find(1)
#       get :new
#       expect(response).to render_template("new")
#     end
#   end
#
#   describe "POST #new" do
#     it "create a new product" do
#       sign_in User.find(1)
#       post :create, product: { title: 'First_Product', description: 'test', category_id: 1, image_url: 'test.jpg', price: 90 }
#       expect(response).to redirect_to(product_path(Product.find_by(title: 'First_Product')))
#     end
#   end
#
#   describe "PATCH #edit" do
#     it "update a product" do
#       sign_in User.find(1)
#       post :create, product: { title: 'Second_Product', description: 'test', category_id: 1, image_url: 'test.jpg', price: 90 }
#       put :update, :id => 1, :product => {:title => "Second_Product"}
#       expect(response).to redirect_to(product_path)
#     end
#   end
#
#   describe "DELETE #destroy" do
#     it "destroy a product" do
#       sign_in User.find(1)
#       delete :destroy, id: 1, :product => {:title => "First_Product"}
#       expect(response).to redirect_to(store_path)
#     end
#   end
# end
