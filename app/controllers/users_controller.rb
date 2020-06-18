class UsersController < ApplicationController

  before_action :set_class, only:[:new, :create]

  def set_class
    @col = 'col-md-offset-4 col-md-4'
    @frame_design = ''
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new

  end

  def create
    @user = User.new(user_params)
    log_in @user

    if @user.save
      flash[:success] = "Muscle Platformへようこそ！"
      redirect_to @user

    else
      render 'new'
    end
  end

private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
