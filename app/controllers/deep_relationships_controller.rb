class DeepRelationshipsController < ApplicationController
  before_action :logged_in_user

  def create
    @user = User.find(params[:teacher_id])
    current_user.teacher = @user
      respond_to do |format|
        format.html { redirect_to @user }
        format.js
    end
  end

  def destroy
    @user = DeepRelationship.find(params[:id]).teacher
    if @user == current_user
      DeepRelationship.find(params[:id]).destroy
      redirect_to students_user_url current_user
    else
      current_user.not_teacher(@user)
      respond_to do |format|
        format.html { redirect_to @user }
        format.js
      end
    end
  end
end
