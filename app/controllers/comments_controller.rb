# frozen_string_literal: true

class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      redirect_to find_content(@comment), notice: t('controllers.common.notice_create', name: Comment.model_name.human)
    else
      # HTML5の必須入力チェックが機能しなかった場合のエラー時レスポンス
      @error_comment = @comment
      @content = find_content(@comment)
      @comments = @content.comments.order(:created_at).page(params[:page]).per(5)
      case @comment.commentable_type
      when 'Report'
        render 'reports/show'
      when 'Book'
        render 'books/show'
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy!
    redirect_to find_content(@comment), notice: t('controllers.common.notice_destroy', name: Comment.model_name.human)
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :commentable_type, :commentable_id)
  end

  def find_content(comment)
    case comment.commentable_type
    when 'Report'
      Report.find(comment.commentable_id)
    when 'Book'
      Book.find(comment.commentable_id)
    end
  end
end
