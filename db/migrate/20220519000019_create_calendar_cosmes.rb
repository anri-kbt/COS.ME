class CreateCalendarCosmes < ActiveRecord::Migration[6.1]
  def change
    create_table :calendar_cosmes do |t|
      t.references :cosmetic, foreign_key: true
      t.references :calendar, foreign_key: true

      t.timestamps
    end
  end
end
