class CreateRecipeComments < ActiveRecord::Migration[6.1]
  def change
    create_table :recipe_comments do |t|
      
      t.integer :user_id
      t.integer :post_recipe_id
      t.text :comment

      t.timestamps
    end
  end
end
