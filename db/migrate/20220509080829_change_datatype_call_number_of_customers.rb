class ChangeDatatypeCallNumberOfCustomers < ActiveRecord::Migration[6.1]
  def change
    change_column :customers, :call_number, :string
  end
end
