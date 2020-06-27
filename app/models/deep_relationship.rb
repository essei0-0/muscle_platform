class DeepRelationship < ApplicationRecord
  belongs_to :teacher, class_name: "User"
  belongs_to :student, class_name: "User"
  validates :teacher_id, presence: true
  validates :student_id, presence: true
  validates :teacher_id, uniqueness: { scope: :student_id }
  validate :check_relation


  def check_relation
    if DeepRelationship.find_by(teacher_id: student_id, student_id: teacher_id)
      errors.add(:base, "すでに師弟関係が成立しています")
    end
  end
end
