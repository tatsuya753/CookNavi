class Public::PostRecipesController < ApplicationController

  def index
    @post_recipes = PostRecipe.all
  end

  def show
  end

  def new
    @post_recipe = PostRecipe.new
  end

  def create
    @post_recipe = PostRecipe.new(post_recipe_params)
    @post_recipe.user_id = current_user.id
    @post_recipe.save
    redirect_to post_recipes_path
  end

  def edit
  end

  def update
  end

  def destroy
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
      procedures_attributes: [:body, :_destroy],
      ingredients_attributes: [:name, :amount, :_destroy]
    )
  end

end
