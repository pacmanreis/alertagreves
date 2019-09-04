class AddLanguageToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :language, :string, default: 'Portugal'
    add_column :users, :country, :string, default: 'Portuguese'
    add_column :users, :admin, :boolean, default: false
  end
end
