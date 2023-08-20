class Public::HomesController < ApplicationController

  def top
     @post_recipes = PostRecipe.all.where(post_status: false).order(created_at: :desc).page(params[:page])
  end

end
