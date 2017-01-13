class StoreController < ApplicationController
  skip_before_action :authenticate_user!
  include CurrentCart
  before_action :set_cart

  def index
    if params[:search_query] || params[:category]
      if params[:search_query] == '' and params[:category] == ''
        redirect_to store_path
      elsif params[:category] == ''
        @products = Product.unscoped.order("id ASC").where("title ilike ?", "%#{params[:search_query]}%").paginate(page: params[:page], per_page: 5)
      elsif params[:search_query] == ''
        @products = Product.unscoped.order("id ASC").where(category_id: params[:category]).paginate(page: params[:page], per_page: 5)
      else
        @products = Product.unscoped.order("id ASC").where("title ilike '%#{params[:search_query]}%' AND category_id = ?", params[:category]).paginate(page: params[:page], per_page: 5)
      end
    else
      @products = Product.unscoped.order("id ASC").paginate(page: params[:page], per_page: 5)
    end
  end
end
