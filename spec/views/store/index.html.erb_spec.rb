# require 'rails_helper.rb'
#
# describe "store/index.html.erb", :type => :view do
#   it "displays the id attribute of the store" do
#     assign(:products, double("products", empty?: true, each: {id: 1, title:'CoffeeScript'}, total_pages: 1))
#     render
#     expect(rendered).to include("store")
#   end
#
#   it "displays the empty index of the store" do
#     product = stub_model(Product)
#     assign(:products, double("products", empty?: false, each: {id: 1, title:'CoffeeScript'}, total_pages: 1))
#     render
#     expect(rendered).not_to include("CoffeeScript")
#   end
# end
