class AddDetailedProfileToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :bio, :text
    add_column :users, :url, :string
    add_column :users, :tel, :string, unique: true
    add_column :users, :birthday, :date
    add_column :users, :gender, :integer
  end
end
