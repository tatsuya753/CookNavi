class Admin::PostRecipesController < ApplicationController

  def index
    @recipe_comment = RecipeComment.all
    @categories = Category.all
    if
      params[:category_id].present?
      @post_recipes = PostRecipe.where("category_id LIKE?","%#{params[:category_id]}%")
    elsif
      params[:word].present?
      @post_recipes = PostRecipe.where('title LIKE ?', "%#{params[:word]}%")
    else
      @post_recipes = PostRecipe.all
    end
  end

  def show
    @post_recipe = PostRecipe.find(params[:id])
    @recipe_comment = RecipeComment.all
  end
end
