class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def show
    @micropost = Micropost.find_by(id: params[:id])
    @reply = Reply.new
    @replies = @micropost.replies.where(reply_id: nil)
  end

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "投稿しました！"
      redirect_to root_url
    else
      flash[:success] = "投稿に失敗しました！"
      redirect_to request.referer
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = "投稿を削除しました！"
    redirect_to root_url
  end

  private

  def micropost_params
    params.require(:micropost).permit(:content, :picture)
  end

  def correct_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    redirect_to root_url if @micropost.nil?
  end

end
