class LikesController < ApplicationController
  def create
    @like = current_user.likes.create(micropost_id: params[:micropost_id])
    create_like_notification!(current_user)
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @like = Like.find_by(post_id: params[:post_id], user_id: current_user.id)
    @like.destroy
    redirect_back(fallback_location: root_path)
  end
end