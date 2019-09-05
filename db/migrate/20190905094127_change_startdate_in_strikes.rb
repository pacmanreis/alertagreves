class ChangeStartdateInStrikes < ActiveRecord::Migration[5.2]
  def change
    change_column :strikes, :start_date, :date
    change_column :strikes, :end_date, :date
  end
end
