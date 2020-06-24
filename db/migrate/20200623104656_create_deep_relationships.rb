class CreateDeepRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :deep_relationships do |t|
      t.integer :teacher_id
      t.integer :student_id

      t.timestamps
    end
    add_index :deep_relationships, :teacher_id
    add_index :deep_relationships, :student_id
    add_index :deep_relationships, [:teacher_id, :student_id], unique: true
  end
end
