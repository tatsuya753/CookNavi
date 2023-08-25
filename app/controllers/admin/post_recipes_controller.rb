class Admin::PostRecipesController < ApplicationController

  def index
    @recipe_comment = RecipeComment.all
    @categories = Category.all

    if  params[:category_id]
        @category = Category.find(params[:category_id])
        @post_recipes = @category.post_recipes.where(post_status: false).page(params[:page])
    elsif params[:word]
          @post_recipes = PostRecipe.where(post_status: false).looks(params[:word]).page(params[:page])
    else
          @post_recipes = PostRecipe.all.where(post_status: false).includes([:user]).page(params[:page])
    end
  end

  def show
    @post_recipe = PostRecipe.find(params[:id])
    @recipe_comment = RecipeComment.all
  end

  def destroy
    post_recipe = PostRecipe.find(params[:id])
    post_recipe.destroy
    redirect_to admin_root_path, notice: "レシピを削除しました！"
  end

end
