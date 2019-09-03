class AddSectorIdToCategories < ActiveRecord::Migration[5.2]
  def change
    add_column :categories, :sector_id, :string
  end
end
