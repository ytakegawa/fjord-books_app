class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  before_action :move_to_signed_in

  def index
    @users = User.order(:id).page(params[:page])
  end

  def new
  end

  def show
    unless @user.id == current_user.id
      redirect_to users_path
    end
  end

  def edit
  end

  def set_user
    @user = User.find(params[:id])
  end

  private

  def move_to_signed_in
    unless user_signed_in?
      redirect_to '/users/sign_in'
    end
  end
end
