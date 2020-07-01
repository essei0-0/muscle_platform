class CreateHealthRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :health_records do |t|
      t.datetime :measured_at, null: false
      t.float :height
      t.float :weight, null: false
      t.float :fat
      t.float :muscle
      t.integer :bmr
      t.float :bmi
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :health_records, [:user_id, :measured_at], unique: true
  end
end
