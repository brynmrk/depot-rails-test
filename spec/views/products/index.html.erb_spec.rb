# require 'rails_helper.rb'
#
# describe "products/index.html.erb", :type => :view do
#   before(:each) do
#     @products = mock_model(Product)
#     @products.stub(empty?: true)
#     @products.stub(each: nil)
#     @products.stub(total_pages: 1)
#   end
#
#   it "displays the index of product" do
#     render
#     expect(rendered).to include("Listing Products")
#   end
#
#   it "displays the empty index of the product" do
#     @products.stub(empty?: false)
#     render
#     expect(rendered).not_to include("CoffeeScript")
#   end
# end
