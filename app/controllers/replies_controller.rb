class RepliesController < ApplicationController

  def create
    if params[:reply_id]
      @reply = Reply.find(params[:reply_id]).replies_to_reply.build(reply_params)
      @reply.user_id = current_user.id
      @reply.micropost_id = params[:micropost_id]
    else
      @reply = current_user.replies.build(reply_params)
      @reply.micropost_id = params[:micropost_id]
    end

    if @reply.save
      flash[:success] = "投稿しました！"
      redirect_to request.referer
    else
      flash[:success] = "投稿に失敗しました！"
      redirect_to request.referer
    end
  end

  def destroy

  end

  private

  def reply_params
    params.require(:reply).permit(:content)
  end
end
