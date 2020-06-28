class CreateHealthRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :health_records do |t|
      t.float :height
      t.float :weight, null: false
      t.float :fat
      t.float :muscle
      t.float :bmr
      t.float :bmi
      t.datetime :measured_at, null: false
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :health_records, [:user_id, :measured_at], unique: true
  end
end
