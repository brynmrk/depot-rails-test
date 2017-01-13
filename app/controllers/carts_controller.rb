class CartsController < ApplicationController
  include CurrentCart
  skip_before_action :authenticate_user!, only: [:create, :update, :destroy]
  before_action :set_cart, only: [:show, :edit, :update, :destroy]

  # GET /carts
  # GET /carts.json
  def index
    if current_user.admin?
      @carts = Cart.unscoped.order("id ASC").paginate(:page => params[:page], :per_page => 20)
    else
      redirect_to store_path, notice: 'You are not authorize to access the link!'
    end
  end

  # GET /carts/1
  # GET /carts/1.json
  def show
    if current_user.admin?

    else
      redirect_to store_path, notice: 'You are not authorize to access the link!'
    end
  end

  # GET /carts/1/edit
  def edit
    if !current_user.admin?
      redirect_to store_path, notice: 'You are not authorize to access the link!'
    end
  end

  # POST /carts
  # POST /carts.json
  def create
    @cart = Cart.new(cart_params)

    respond_to do |format|
      if @cart.save
        format.html { redirect_to @cart, notice: 'Cart was successfully created.' }
        format.json { render action: 'show', status: :created, location: @cart }
      else
        format.html { render action: 'new' }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /carts/1
  # PATCH/PUT /carts/1.json
  def update
    respond_to do |format|
      if @cart.update(cart_params)
        format.html { redirect_to @cart, notice: 'Cart was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /carts/1
  # DELETE /carts/1.json
  def destroy
    if @cart.id == session[:cart_id]
      @cart.delete
      session[:cart_id] = nil
    end

    respond_to do |format|
      format.html { redirect_to store_url }
      format.json { head :no_content }
    end
  end

  def process(action, *args)
    super
  rescue AbstractController::ActionNotFound , ActiveRecord::RecordNotFound
    respond_to do |format|
      format.html { redirect_to store_path, notice: 'Invalid Link!' }
    end
  end

  # ...
  private
  # ...

    def set_cart
      @cart = Cart.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cart_params
      params[:cart]
    end
end
