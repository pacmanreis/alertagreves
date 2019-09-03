class CreateUnions < ActiveRecord::Migration[5.2]
  def change
    create_table :unions do |t|
      t.string :name
      t.string :initials
      t.string :url

      t.timestamps
    end
  end
end
