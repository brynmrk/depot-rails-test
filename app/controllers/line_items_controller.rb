class LineItemsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:create]
  include CurrentCart
  before_action :set_cart, only: [:create]
  before_action :set_line_item, only: [:show, :edit, :update, :destroy]

  # GET /line_items
  # GET /line_items.json
  def index
    @line_items = LineItem.unscoped.order("id ASC").paginate(:page => params[:page], :per_page => 20)
  end

  # POST /line_items
  # POST /line_items.json
  def create
    product = Product.find(params[:product_id])
    type = params[:type]

    @line_item = @cart.increment_product(product.id) if type == 'increment'
    @line_item = @cart.decrement_product(product.id) if type == 'decrement'

    respond_to do |format|
      if @line_item.save
        format.html { redirect_to store_url }
        format.js { @current_item = @line_item }
        format.json { render action: 'show', status: :created, location: @line_item }
      else
        format.html { render action: 'new' }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /line_items/1
  # PUT /line_items/1.json
  def increment
    # increment through method in @line_item
    product = Product.find(params[:product_id])
    type = params[:type]

    @line_item = @cart.line_items.find_by_id(product.id)
    @line_item = @line_item.increment_quantity(@line_item.id) if type == 'increment'
    @line_item = @line_item.decrement_quantity(@line_item.id) if type == 'decrement'

    respond_to do |format|
      if @line_item.save
        format.html { redirect_to store_path, notice: 'Line item was successfully updated.' }
        format.js {@current_item = @line_item}
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.js {@current_item = @line_item}
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
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
    def set_line_item
      @line_item = LineItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def line_item_params
      params.require(:line_item).permit(:product_id)
    end
end
