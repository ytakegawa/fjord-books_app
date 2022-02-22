# frozen_string_literal: true

class BooksController < ApplicationController
  before_action :set_content, only: %i[show edit update destroy]

  # GET /books
  # GET /books.json
  def index
    @books = Book.order(:id).page(params[:page])
  end

  # GET /books/1
  # GET /books/1.json
  def show
    @comments = @content.comments.order(:created_at).page(params[:page]).per(5)
    @comment = @content.comments.build(user_id: current_user.id)
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit; end

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: t('controllers.common.notice_create', name: Book.model_name.human) }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    respond_to do |format|
      if @content.update(book_params)
        format.html { redirect_to @content, notice: t('controllers.common.notice_update', name: Book.model_name.human) }
        format.json { render :show, status: :ok, location: @content }
      else
        format.html { render :edit }
        format.json { render json: @content.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @content.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: t('controllers.common.notice_destroy', name: Book.model_name.human) }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_content
    @content = Book.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def book_params
    params.require(:book).permit(:title, :memo, :author, :picture)
  end
end
