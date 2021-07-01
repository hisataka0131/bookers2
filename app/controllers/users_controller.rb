class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update]

  def show
  	@user = User.find(params[:id])
  	@books = @user.books
  	@book = Book.new
  end

  def index
  	@book = Book.new
    @users = User.all.order(created_at: :desc)
    @user = current_user
  end

  def edit
    @user = User.find(current_user.id)
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      # flash[:notice] = "User was successfully updated"
      redirect_to user_path(@user.id)
    else
      render action: :edit
    end
  end

  def create
      @book = Book.new(books_params)
      @book.user_id = current_user.id
      @book.save
      redirect_to book_path(@users)
  end

    private
    def correct_user
        @user = User.find(params[:id])
        if current_user != @user
        redirect_to root_path
        end
    end
    def user_params
     params.require(:user).permit(:name ,:image,:introduction)
    end
end
