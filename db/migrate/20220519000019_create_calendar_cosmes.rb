class CreateCalendarCosmes < ActiveRecord::Migration[6.1]
  def change
    create_table :calendar_cosmes do |t|
      t.integer :cosmetic_id
      t.integer :calendar_id

      t.timestamps
    end
  end
end
