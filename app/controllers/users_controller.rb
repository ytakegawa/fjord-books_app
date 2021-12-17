class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.order(:id).page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
  end
end
