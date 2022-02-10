class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.build(comment_params)
    commentable_type = Report.find(@comment.commentable_id) if @comment.commentable_type == 'Report'
    commentable_type ||= Book.find(@comment.commentable_id)
    respond_to do |format|
      if @comment.save
        format.html { redirect_to polymorphic_path(commentable_type), notice: t('controllers.common.notice_create', name: Comment.model_name.human) }
      else
        @error_comment = @comment
        case params[:comment][:commentable_type]
        when 'Report'
          @report = Report.find(params[:report_id])
          @comments = @report.comments.order(:created_at).page(params[:page]).per(5)
          format.html { render 'reports/show' }
        when 'Book'
          @book = Book.find(params[:book_id])
          @books = @book.comments.order(:created_at).page(params[:page]).per(5)
          format.html { render 'books/show' }
        end
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    commentable_type = Report.find(@comment.commentable_id) if @comment.commentable_type == 'Report'
    commentable_type ||= Book.find(@comment.commentable_id)
    @comment.destroy
    commentable_id = params[:report_id]
    commentable_id ||= params[:book_id]
    respond_to do |format|
      format.html { redirect_to polymorphic_path(commentable_type), notice: t('controllers.common.notice_destroy', name: Comment.model_name.human) }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :commentable_type, :commentable_id)
  end
end
