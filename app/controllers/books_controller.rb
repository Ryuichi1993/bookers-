class BooksController < ApplicationController
before_action :authenticate_user!
before_action :correct_user,   only: [:edit, :update, :destroy]

def index
	@book = Book.new
	@books = Book.all
	@user = current_user
	@users = User.all
end

def show
	@book = Book.find(params[:id])
	@books = Book.new
    @comment = BookComment.new
    @user = User.all
end

def create
	@book = Book.new(book_params)
	@book.user_id = current_user.id
    if @book.save
      flash[:notice] = "Book was successfully saved."
	  redirect_to book_path(@book.id)
    else
      @books = Book.all
      render :index
    end
end

def destroy
	if @book = Book.find(params[:id])
	   @book.user_id == current_user.id
	   @book.destroy
	   flash[:notice] = "Book was successfully destroyed."
	   redirect_to books_path(@book.id)
	else
	   render :edit
	end
end


def edit
	@book = Book.find(params[:id])
end

def update
	@book = Book.find(params[:id])
	if @book.update(book_params)
	   flash[:notice] = "Book was successfully updated."
	   redirect_to book_path
	else
	   render :edit
	end
end

def search
	user_name_ids = User.where("user_name = ?", params[:user_name]) .pluck(:id)
	book_title_ids = Book.where("book_title LIKE (?)", "#{params[:book_title]}").pluck(:id)
	@book_searched = Book.where("book_id IN (?) or book_id IN (?)", user_name_ids, book_title_ids)
	
end


private
def book_params
	params.require(:book).permit(:title, :body)
end
def correct_user
	@book = Book.find(params[:id])
	unless
	@book.user == current_user
      redirect_to books_path
    end
end
end
