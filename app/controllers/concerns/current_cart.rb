module CurrentCart
  extend ActiveSupport::Concern

  private
    def set_cart
      @cart = Cart.find(session[:cart_id])
    rescue ActiveRecord::RecordNotFound
      @cart = Cart.create
      session[:cart_id] = @cart.id
    end

    def get_user
      @user = User.find(session[:user_id])
    rescue
      session[:user_id] = nil
    end
end
