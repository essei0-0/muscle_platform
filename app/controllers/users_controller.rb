class UsersController < ApplicationController

  before_action :set_class, only:[:new, :create]
  before_action :logged_in_user, only: [:edit, :update,  :following, :followers, :teacher, :students]
  before_action :correct_user,   only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts
    @col = 'col-md-4'
  end

  def new
    @user = User.new

  end

  def create
    @user = User.new(user_params)
    log_in @user

    if @user.save
      log_in @user
      flash[:success] = "ようこそ、Muscle Platformへ！"
      redirect_to root_url
    else
      render 'new'
    end
  end

  def edit

  end

  def update
   if @user.update_attributes(user_params)
     flash[:success] = "更新に成功しました"
     redirect_to @user
   else
     flash.now[:danger] = "更新に失敗しました"
     render 'edit'
   end
 end

 def following
    @title = "フォロー"
    @user  = User.find(params[:id])
    @users = @user.following
    render 'show_follow'
  end

  def followers
    @title = "フォロワー"
    @user  = User.find(params[:id])
    @users = @user.followers
    render 'show_follow'
  end

  def students
    @title = "弟子"
    @user  = User.find(params[:id])
    @users = @user.students
    render 'show_students'
   end

private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :url, :bio, :tel, :image_name)
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  def set_class
    @col = 'col-md-offset-4 col-md-4'
    @frame_design = ''
  end
end
