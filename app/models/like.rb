class Like < ApplicationRecord
  belongs_to :micropost
  belongs_to :user
  validates :micropost_id, uniqueness: { scope: :user_id }
end
