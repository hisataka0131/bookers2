class BooksController < ApplicationController

  before_action :authenticate_user!

  before_action :correct_user, only: [:edit, :update]

  def create
    @book = Book.new(books_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "Book was successfully created"
    	redirect_to book_path(@book.id)
    else
      @books = Book.all.order(created_at: :desc)
            render action: :index
    end
  end

  def index
    @book = Book.new
    @books = Book.all.order(created_at: :desc)
  end

  def show
    @book = Book.find(params[:id])
    @booka = Book.new
  end

  def destroy
    @book = Book.find(params[:id])
    if @book.destroy
      flash[:notice] = "Book was successfully destroyed"
      redirect_to books_path
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    @booka = Book.new
    if @book.update(books_params)
      flash[:notice] = "Book was successfully updated"
      redirect_to book_path(@book.id)
    else
      render action: :edit
    end
  end

  private
    def correct_user
      @book = Book.find(params[:id])
      if current_user.id != @book.user.id
        redirect_to books_path
      end
    end

    def books_params
      params.require(:book).permit(:title, :body)
    end

end
