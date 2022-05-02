class Repost < ApplicationRecord
  belongs_to :user
  belongs_to :micropost

  def is_reposted?(post_id)
    Repost.find_by(user_id: current_user.id, post_id: post_id).exists?
  end
end
