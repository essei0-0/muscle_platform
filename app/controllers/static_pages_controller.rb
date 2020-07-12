class StaticPagesController < ApplicationController

  def home
    if logged_in?
      @feed_items = current_user.feed
      @trend_items = User.trend_feed
      @reply = Reply.new
    else
      @bg_url = 'jumbotron'
      @col = 'col-md-offset-3 col-md-9'
      @frame_design = 'login_frame_black'
      @user = User.new
    end
  end

  def help
  end

  def about
  end

  def prepare
  end
end
