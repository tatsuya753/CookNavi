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
  
  # 投稿バリデーション
  with_options presence: true, on: :publicize do
    validates :image
    validates :serving
    validates :title
    validates :introduction
  end
  validates :title, length: { maximum: 14 }, on: :publicize
  validates :introduction, length: { maximum: 80 }, on: :publicize

  def get_image(width, height)
      image
      image.variant(resize_to_limit: [width, height]).processed
  end

  def kept_by?(user)
    keeps.exists?(user_id: user.id)
  end
end
