class UsersController < ApplicationController
  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to book_path(:id)
    else
      render :book_path
    end
  end

  def index
    @users = User.all
  end

  def show
    @user =User.find(params[:id])
    @books = @user.books
  end

  def edit
    @user =User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:title, :body, :profile_image)
  end
end
