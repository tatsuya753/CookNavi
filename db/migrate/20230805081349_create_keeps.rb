class CreateKeeps < ActiveRecord::Migration[6.1]
  def change
    create_table :keeps do |t|
      
      t.integer :user_id
      t.integer :post_recipe_id

      t.timestamps
    end
  end
end
