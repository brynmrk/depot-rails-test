class UsersController < ApplicationController
  before_filter :authenticate_user!

  # GET /users
  # GET /users.json
  def index
    @users = User.unscoped.order("id ASC").paginate(:page => params[:page], :per_page => 5)
  end

  def process(action, *args)
    super
  rescue AbstractController::ActionNotFound, ActiveRecord::RecordNotFound
    respond_to do |format|
      format.html { redirect_to store_path, notice: 'Invalid Link!' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :password, :password_confirmation, :email)
    end
end
