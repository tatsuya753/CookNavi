class CreatePostRecipes < ActiveRecord::Migration[6.1]
  def change
    create_table :post_recipes do |t|

      t.timestamps
    end
  end
end
