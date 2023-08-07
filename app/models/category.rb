class Category < ApplicationRecord
  
  has_many :post_recipes, dependent: :destroy
  
end
