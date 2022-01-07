class FollowsController < ApplicationController
  before_action :set_user

  def create
    current_user.follow(@user)
    redirect_to user_path(@user)
  end

  def destroy
    # Follow.find(params[:followed_id]).followed
    current_user.unfollow(@user)
    redirect_to user_path(@user)
  end

  def set_user
    @user = User.find(params[:followed_id])
  end
end
