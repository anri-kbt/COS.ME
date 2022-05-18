class CreateCosmeComments < ActiveRecord::Migration[6.1]
  def change
    create_table :cosme_comments do |t|
      t.integer :customer_id
      t.integer :cosmetic_id
      t.text :comment

      t.timestamps
    end
  end
end
