class CreateStrikes < ActiveRecord::Migration[5.2]
  def change
    create_table :strikes do |t|
      t.string :country
      t.string :organization
      t.string :descrpition
      t.datetime :start_date
      t.datetime :end_date
      t.references :syndicate, foreign_key: true
      t.references :category, foreign_key: true
      t.references :sector, foreign_key: true

      t.timestamps
    end
  end
end
