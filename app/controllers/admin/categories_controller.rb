class Admin::CategoriesController < ApplicationController

  def index
    @categories = Category.all
    @category = Category.new

  end

  def create
    @category = Category.new(category_params)
		if @category.save
		   @categories = Category.all
		   render :index
		else
		  @caterories = Category.all
		   redirect_back(fallback_location: root_path)
		end
  end

  def edit

  end

  def update

  end

  private
  def category_params
	  params.require(:category).permit(:name)
	end

end
