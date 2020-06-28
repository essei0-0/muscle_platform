class HealthRecord < ApplicationRecord
  belongs_to :user
  default_scope -> { order(measured_at: :desc) }
  validates :user_id, presence: true
  validates :weight, presence: true
end
