class ProductsController < ApplicationController
  skip_before_filter :authenticate_user!, only: [:show]
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  # GET /products
  # GET /products.json
  def index
    if current_user.admin?
      @products = Product.unscoped.order("id ASC").paginate(:page => params[:page], :per_page => 5)
    else
      redirect_to store_path, notice: 'You are not authorize to access the link!'
    end
  end

  # GET /products/1
  # GET /products/1.json
  def show
  end

  # GET /products/new
  def new
    if current_user.admin?
      @product = Product.new
    else
      redirect_to store_path, notice: 'You are not authorize to access the link!'
    end
  end

  # GET /products/1/edit
  def edit
    if current_user.admin?

    else
      redirect_to store_path, notice: 'You are not authorize to access the link!'
    end
  end

  # POST /products
  # POST /products.json
  def create
    if current_user.admin?
      @product = Product.new(product_params)

      respond_to do |format|
        if @product.save
          format.html { redirect_to products_path, notice: 'Product was successfully created.' }
          format.json { render action: 'show', status: :created, location: @product }
        else
          format.html { render action: 'new' }
          format.json { render json: @product.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to store_path, notice: 'You are not authorize to access the link!'
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    if current_user.admin?
      respond_to do |format|
        if @product.update(product_params)
          format.html { redirect_to products_path, notice: 'Product was successfully updated.' }
          format.json { render :show, status: :ok, location: @product }
        else
          format.html { render action: 'edit' }
          format.json { render json: @product.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to store_path, notice: 'You are not authorize to access the link!'
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    if current_user.admin?
      @product.delete
      respond_to do |format|
        format.html { redirect_to products_url }
        format.json { head :no_content }
      end
    else
      redirect_to store_path, notice: 'You are not authorize to access the link!'
    end
  end

  def who_bought
    @product = Product.find(params[:id])
    @latest_order = @product.orders.order(:updated_at).last
    if stale?(@latest_order)
      respond_to do |format|
        format.atom
      end
    end
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
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:title, :description, :image_url, :price, :category_id)
    end
end
