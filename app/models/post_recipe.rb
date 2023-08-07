class PostRecipe < ApplicationRecord
  
  belongs_to :user
  belongs_to :category
  
  has_many :recipe_comments, dependent: :destroy
  has_many :keeps, dependent: :destroy
  has_many :ingredients, dependent: :destroy
  has_many :procedures, dependent: :destroy
  
end
