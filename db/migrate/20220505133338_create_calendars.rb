class CreateCalendars < ActiveRecord::Migration[6.1]
  def change
    create_table :calendars do |t|
      t.references :customer, foreign_key: true
      t.references :cosmetic, foreign_key: true
      t.datetime :used_date
      
      t.timestamps
    end
  end
end
