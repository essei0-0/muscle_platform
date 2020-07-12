class CreateReplies < ActiveRecord::Migration[5.2]
  def change
    create_table :replies do |t|
      t.text :content
      t.integer :reply_id
      t.references :user, foreign_key: true
      t.references :micropost, foreign_key: true

      t.timestamps
    end
    add_index :replies, [:user_id, :created_at]
    add_index :replies, [:micropost_id, :created_at]
  end
end
