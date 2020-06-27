class SessionsController < ApplicationController
  def new
    @user = User.new
    @col = 'col-md-offset-4 col-md-4'
    @frame_design = 'login_frame_white'
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      remember user
      flash[:success] = "#{user.name}さん、お帰りマッスル！"
      redirect_back_or root_url
    else
      # エラーメッセージを作成する
      @error = ''
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
