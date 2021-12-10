class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]

  def new
  end

  def show; end

  def edit; end

  def set_user
    @user = User.find(params[:id])
  end
end
