class RemoveSectorIdFromStrikes < ActiveRecord::Migration[5.2]
  def change
    remove_column :strikes, :sector_id, :string
  end
end
