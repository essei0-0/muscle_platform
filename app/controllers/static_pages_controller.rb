class StaticPagesController < ApplicationController

  def home
    @bg_url = 'jumbotron'
    @user = User.new
    @col = 'col-md-offset-3 col-md-9'
    @frame_design = 'login_frame_black'
  end

  def help
  end

  def about
  end
end
