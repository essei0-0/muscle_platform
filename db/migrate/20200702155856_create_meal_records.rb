class CreateMealRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :meal_records do |t|
      t.datetime :ate_at, null: false
      t.string :food
      t.float :ate_gram
      t.float :protein
      t.float :fat
      t.float :carbo
      t.integer :calorie
      t.integer :base_gram
      t.text :note
      t.string :picture
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :meal_records, [:user_id, :ate_at]
  end
end
