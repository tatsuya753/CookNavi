class Public::KeepsController < ApplicationController

  def create
    post_recipe = PostRecipe.find(params[:post_recipe_id])
    keep = current_user.keeps.new(post_recipe_id: post_recipe.id)
    keep.save
    redirect_to request.referer
  end

  def destroy
    post_recipe = PostRecipe.find(params[:post_recipe_id])
    keep = current_user.keeps.find_by(post_recipe_id: post_recipe.id)
    keep.destroy
    redirect_to request.referer
  end

end
