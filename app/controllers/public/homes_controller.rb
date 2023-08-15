class Public::HomesController < ApplicationController

  def top
     @post_recipes = PostRecipe.all.where(post_status: false).order(created_at: :desc).limit(9)
  end

end
