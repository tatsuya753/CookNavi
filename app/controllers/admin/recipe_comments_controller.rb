class Admin::RecipeCommentsController < ApplicationController

  def destroy
    RecipeComment.find(params[:id]).destroy
    redirect_to admin_post_recipe_path(params[:post_recipe_id])
  end

  private

  def recipe_comment_params
    params.require(:recipe_comment).permit(:comment)
  end

end