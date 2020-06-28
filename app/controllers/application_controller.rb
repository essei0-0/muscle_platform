class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  before_action :prepare_micropost, except: [:create, :destroy]

  private
  # ユーザーのログインを確認する
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "ログインしてください"
      redirect_to login_url
    end
  end

  def prepare_micropost
    if logged_in?
      @new_micropost = current_user.microposts.build
    end
  end
end
