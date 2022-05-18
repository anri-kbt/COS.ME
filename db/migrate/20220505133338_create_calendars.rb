class CreateCalendars < ActiveRecord::Migration[6.1]
  def change
    create_table :calendars do |t|
      t.integer :customer_id
      t.integer :cosmetic_id
      t.datetime :used_date
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
  end
end
