class CreateSyndicates < ActiveRecord::Migration[5.2]
  def change
    create_table :syndicates do |t|
      t.string :name
      t.string :initials
      t.string :url

      t.timestamps
    end
  end
end
