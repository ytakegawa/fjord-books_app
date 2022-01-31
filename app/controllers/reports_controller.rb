class ReportsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @reports = @user.reports.order(:created_at).page(params[:page])
  end
end
