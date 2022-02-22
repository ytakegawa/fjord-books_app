# frozen_string_literal: true

class ReportsController < ApplicationController
  before_action :set_content, only: %i[show edit update destroy]
  before_action :correct_user, only: %i[edit update destroy]

  def index
    @user = User.find(params[:user_id])
    @reports = @user.reports.order(:created_at).page(params[:page]).per(5)
  end

  def show
    @comments = @content.comments.order(:created_at).page(params[:page]).per(5)
    @comment = @content.comments.build(user_id: current_user.id)
  end

  def edit; end

  def new
    @report = Report.new
  end

  def create
    @report = current_user.reports.build(report_params)
    if @report.save
      redirect_to @report, notice: t('controllers.common.notice_create', name: Report.model_name.human)
    else
      render :new
    end
  end

  def update
    if @content.update(report_params)
      redirect_to @content, notice: t('controllers.common.notice_update', name: Report.model_name.human)
    else
      render :new
    end
  end

  def destroy
    @content.destroy
    redirect_to user_reports_path(@content.user_id), notice: t('controllers.common.notice_destroy', name: Report.model_name.human)
  end

  private

  def set_content
    @content = Report.find(params[:id])
  end

  def report_params
    params.require(:report).permit(:title, :content)
  end

  def correct_user
    redirect_to users_path unless current_user.id == @content.user_id
  end
end
