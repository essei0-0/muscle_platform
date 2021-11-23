class UsersController < ApplicationController

  before_action :set_class, only:[:new, :create]
  before_action :logged_in_user, only: [:edit, :update,  :following, :followers, :teacher, :students]
  before_action :correct_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.where.not(picture: nil)
    @col = 'col-md-4'
  end

  #get '/signup',  to: 'users#new'
  def new
    if logged_in?
      redirect_to (request.referer || root_url), status: 403
      flash[:danger] = "既にログインしています。"
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "#{@user.name}さん、ようこそMuscle Platformへ！"
      redirect_to root_url, status: 303
    else
      render 'new'
    end
  end

  def edit
    @male = @female = @default = false
    if @user.gender == 1
      @male = true
    elsif @user.gender == 2
      @female = true
    else
      @default = true
    end


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
    @follow_class = "active"
    render 'users/relationship'
  end

  def followers
    @title = "フォロワー"
    @user  = User.find(params[:id])
    @users = @user.followers
    @follower_class = "active"
    render 'users/relationship'
  end

  def students
    @title = "弟子"
    @user  = User.find(params[:id])
    @users = @user.students
    @students_class = "active"
    render 'users/relationship'
   end

   def health_records
     h = current_user.health_records
     @health_records = h.take(current_user.health_records.count)
     @health_record = h.build(height: h.first&.height, weight: h.first&.weight, fat: h.first&.fat, measured_at: DateTime.now)

   end

private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :url, :bio, :tel, :image_name, :birthday, :gender)
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
