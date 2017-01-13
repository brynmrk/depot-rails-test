# require 'rails_helper.rb'
#
# describe "products/new.html.erb", :type => :view do
#   before(:each) do
#     @products = mock_model(Product)
#     @products.stub(empty?: true)
#     @products.stub(each: nil)
#     @products.stub(total_pages: 1)
#   end
#
#   it "renders form to create a product" do
#     assign(:products, double("products", empty?: true, each: {id: 1, title:'CoffeeScript'}, total_pages: 1))
#     render
#     expect(rendered).to include("products")
#     # form_for = double("form_for")
#     # expect(form_for).to include("form",
#     #   method: "post",
#     #   action: store_path
#     # ) do |form|
#     #   expect(form).to include("input", type: "submit")
#     # end
#   end
# end
