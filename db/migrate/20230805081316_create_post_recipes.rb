class CreatePostRecipes < ActiveRecord::Migration[6.1]
  def change
    create_table :post_recipes do |t|

      t.integer :user_id
      t.integer :category_id
      t.string :title
      t.text :introduction
      t.integer :serving
      t.boolean :post_status, default: false

      t.timestamps
    end
  end
end
