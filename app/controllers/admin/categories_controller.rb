class Admin::CategoriesController < ApplicationController

  def index
    @categories = Category.all
    @category = Category.new

  end

  def create
    @category = Category.new(category_params)
    if @category.save
       @categories = Category.all
       redirect_to admin_categories_path
    else
      @caterories = Category.all
       redirect_back(fallback_location: root_path)
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      redirect_to admin_categories_path
    else
      redirect_back(fallback_location: root_path)
    end

  end

  private
  def category_params
    params.require(:category).permit(:name)
  end

end
