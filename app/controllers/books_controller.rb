class BooksController < ApplicationController

  def create
    @newbook = Book.new (book_params)
    @newbook.user_id = current_user.id
    @user = current_user
    if @newbook.save
    flash[:notice] = "You have created book successfully."
    redirect_to book_path(@newbook.id)
    else
    @books = Book.all
    render :index
    end
  end

  def index
    @books = Book.all
    @user = current_user
    @newbook =Book.new
  end

  def show
    @book =Book.find(params[:id])
    @user =@book.user
    @newbook =Book.new
  end

  def edit
     check_login_user
     @book =Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
    flash[:notice] = "You have updated book successfully."
    redirect_to book_path(@book.id)
    else
    render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
  def check_login_user
      book = Book.find(params[:id])
    unless book.user_id == current_user.id
      redirect_to books_path
    end
  end
end
