class CreateSubmittedStrikes < ActiveRecord::Migration[5.2]
  def change
    create_table :submitted_strikes do |t|
      t.string :country
      t.string :organization
      t.string :description
      t.string :status
      t.date :start_date
      t.date :end_date
      t.references :union, foreign_key: true
      t.references :category, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
