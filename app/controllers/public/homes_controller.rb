class Public::HomesController < ApplicationController

  def top
     @post_recipes = PostRecipe.order(created_at: :desc).limit(9)
  end

end
