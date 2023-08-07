class PostRecipe < ApplicationRecord
  
  belongs_to :user
  belongs_to :category
  
  has_many :recipe_comments, dependent: :destroy
  has_many :keeps, dependent: :destroy
  has_many :ingredients, dependent: :destroy
  has_many :procedures, dependent: :destroy
  has_one_attached :image
  
  # 関連付けしたモデルを一緒にデータ保存できるようにする
  accepts_nested_attributes_for :procedures, allow_destroy: true
  accepts_nested_attributes_for :ingredients, allow_destroy: true
  
  def get_image
    if image.attached?
      image
    else
      'no_image.jpg'
    end
  end
  
end
