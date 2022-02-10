class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.build(comment_params)
    respond_to do |format|
      if @comment.save
        format.html { redirect_to polymorphic_path(find_content(@comment)), notice: t('controllers.common.notice_create', name: Comment.model_name.human) }
      else
        # HTML5の必須入力チェックが機能しなかった場合のエラー時レスポンス
        @error_comment = @comment
        case params[:comment][:commentable_type]
        when 'Report'
          @report = Report.find(params[:report_id])
          @comments = @report.comments.order(:created_at).page(params[:page]).per(5)
          format.html { render 'reports/show' }
        when 'Book'
          @book = Book.find(params[:book_id])
          @comments = @book.comments.order(:created_at).page(params[:page]).per(5)
          format.html { render 'books/show' }
        end
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to polymorphic_path(find_content(@comment)), notice: t('controllers.common.notice_destroy', name: Comment.model_name.human) }
    end
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
