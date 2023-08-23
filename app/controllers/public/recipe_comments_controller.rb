class Public::RecipeCommentsController < ApplicationController
  before_action :authenticate_user!

  def create
        post_recipe = PostRecipe.find(params[:post_recipe_id])
        comment = current_user.recipe_comments.new(recipe_comment_params)
        comment.post_recipe_id = post_recipe.id
    if  comment.save
        redirect_to post_recipe_path(post_recipe), notice: "コメントを投稿しました！"
    else
        flash[:alert] = "コメントを投稿できませんでした。"
        redirect_to request.referer

    end
  end

  def destroy
    RecipeComment.find(params[:id]).destroy
    redirect_to post_recipe_path(params[:post_recipe_id]), notice: "コメントを削除しました！"
  end

  private

  def recipe_comment_params
    params.require(:recipe_comment).permit(:comment)
  end

end
