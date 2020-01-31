class SearchsController < ApplicationController

def index
    @bookss = Book.search(params[:search])
    @user_or_book = params[:option]
    if @user_or_book == "1"
    	@user = User.search(params[:search], @user_or_post)
    else
    	@book = Book.search(params[:search], @user_or_book)
    end
end