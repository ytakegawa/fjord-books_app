class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.order(:id).page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
    unless @user.id == current_user.id
      redirect_to users_path
    end
  end
end
