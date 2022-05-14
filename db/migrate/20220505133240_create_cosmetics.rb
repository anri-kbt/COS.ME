class CreateCosmetics < ActiveRecord::Migration[6.1]
  def change
    create_table :cosmetics do |t|
      t.references :brand, foreign_key: true, index: { unique: true }
      t.references :customer, foreign_key: true, index: { unique: true }
      t.references :category, foreign_key: true, index: { unique: true }
      t.references :calendar, foreign_key: true, index: { unique: true }
      t.string :cosmetic_name
      t.integer :price
      t.text :introduction
      t.integer :public_status ,default:0, null: false
      t.float :evaluation, null: false

      t.timestamps
    end
  end
end
