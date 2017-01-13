class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  respond_to :html

  def index
    @categories = Category.unscoped.order("id ASC").all
    respond_with(@categories)
  end

  def show
    respond_with(@category)
  end

  def new
    @category = Category.new
    respond_with(@category)
  end

  def edit
  end

  def create
    @category = Category.new(category_params)
    @category.save
    respond_with(@category, location: categories_path, notice: "Category was successfully created")
  end

  def update
    @category.update(category_params)
    respond_with(@category, location: categories_path, notice: "Category was successfully updated")
  end

  def destroy
    @category.delete
    respond_with(@category)
  end

  def process(action, *args)
    super
  rescue AbstractController::ActionNotFound, ActiveRecord::RecordNotFound
    respond_to do |format|
      format.html { redirect_to store_path, notice: 'Invalid Link!' }
    end
  end

  private
    def set_category
      @category = Category.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:name, :description)
    end
end
