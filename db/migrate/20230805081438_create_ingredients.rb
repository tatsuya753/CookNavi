class CreateIngredients < ActiveRecord::Migration[6.1]
  def change
    create_table :ingredients do |t|
      
      t.integer :post_recipes_id
      t.string :name
      t.integer :amount

      t.timestamps
    end
  end
end
