class AddDefaultsSubmittedStrikes < ActiveRecord::Migration[5.2]
  def change
    change_column_default :submitted_strikes, :country, "Portugal"
    change_column_default :submitted_strikes, :status, "Pending"
  end
end
