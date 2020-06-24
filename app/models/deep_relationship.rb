class DeepRelationship < ApplicationRecord
  belongs_to :teacher, class_name: "User"
  belongs_to :student, class_name: "User"
  validates :teacher_id, presence: true
  validates :student_id, presence: true
end
