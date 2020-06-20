class AddDetailedProfileToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :bio, :text, null: true
    add_column :users, :url, :string, null: true
    add_column :users, :tel, :string, null: true, unique: true
  end
end
