class Public::PostRecipesController < ApplicationController

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
    @recipe_comment = RecipeComment.new
  end

  def new
    @post_recipe = PostRecipe.new
    @post_recipe.ingredients.build
    @post_recipe.procedures.build
  end

  def create
    @post_recipe = PostRecipe.new(post_recipe_params)
    @post_recipe.user_id = current_user.id
    @post_recipe.save
    redirect_to post_recipe_path(@post_recipe.id)
  end

  def edit
    @post_recipe = PostRecipe.find(params[:id])
  end

  def update
    post_recipe = PostRecipe.find(params[:id])
    post_recipe.update(post_recipe_params)
    redirect_to post_recipe_path
  end

  def destroy
    post_recipe = PostRecipe.find(params[:id])
    post_recipe.destroy
    redirect_to post_recipes_path
  end

private

  def post_recipe_params
    params.require(:post_recipe).permit(
      :user_id,
      :category_id,
      :title,
      :introduction,
      :serving,
      :post_status,
      :image,
      procedures_attributes: [:body, :_destroy, :id],
      ingredients_attributes: [:name, :amount, :_destroy, :id]
    )
  end

end
