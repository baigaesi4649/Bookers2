class UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(:id)
    else
      render :user_path
    end
  end

  def index
    @users = User.all
    @user =current_user
    @newbook = Book.new
  end

  def show
    @user =User.find(params[:id])
    @books = @user.books
    @newbook = Book.new
  end

  def edit
    check_login_user
    @user =User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
    flash[:notice] = "You have updated user successfully."
    redirect_to user_path(@user.id)
    else
    render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
  
  def check_login_user
    unless params[:id] == current_user.id.to_s
      redirect_to user_path(current_user)
    end
  end
end

