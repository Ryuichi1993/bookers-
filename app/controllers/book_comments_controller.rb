class BookCommentsController < ApplicationController
before_action :correct_user,   only: [:destroy]
def create
	@book = Book.find(params[:book_id])
	@comment = BookComment.new(book_comment_params)
	@comment.user_id = current_user.id
	@comment.book_id = @book.id
	if @comment.save
    else
    	@book = Book.find(params[:book_id])
    	@books = Book.new
    end

end

def destroy
	@book = Book.find(params[:book_id])
	@comment = current_user.book_comments.find_by(book_id: @book.id)
	if @comment.destroy
	else
		@book = Book.find(params[:book_id])
    	@books = Book.new
	   render :"book/show"
	end
end

private
def book_comment_params
	params.require(:book_comment).permit(:user_id, :book_id, :comment)
end

def correct_user
	@book = Book.find(params[:book_id])
	unless
	@comment = current_user.book_comments.find_by(book_id: @book.id)
      redirect_to books_path
    end
end
end