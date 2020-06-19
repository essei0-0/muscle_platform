class SessionsController < ApplicationController
  def new
    @user = User.new
    @col = 'col-md-offset-4 col-md-4'
    @frame_design = 'login_frame_white'
  end

  def create
    @user = User.new
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      remember user
      redirect_to user
    else
      # エラーメッセージを作成する
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
