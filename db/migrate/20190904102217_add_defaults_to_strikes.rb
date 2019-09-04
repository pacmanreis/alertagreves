class AddDefaultsToStrikes < ActiveRecord::Migration[5.2]
  def change
    change_column_default :strikes, :country, "Portugal"
  end
end
