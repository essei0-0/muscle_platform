class Reply < ApplicationRecord
  belongs_to :user
  belongs_to :micropost
  has_many :replies_to_reply, class_name: "Reply", foreign_key: :reply_id, dependent: :destroy
  has_many :notifications, dependent: :destroy
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :micropost_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
end
