class CreateCosmetics < ActiveRecord::Migration[6.1]
  def change
    create_table :cosmetics do |t|
      t.integer :brand_id
      t.integer :customer_id
      t.integer :category_id
      t.integer :calendar_id
      t.string :cosmetic_name
      t.integer :price
      t.text :introduction
      t.boolean :is_public ,default:true

      t.timestamps
    end
  end
end
