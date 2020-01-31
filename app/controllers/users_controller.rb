class UsersController < ApplicationController
	before_action :authenticate_user!
	before_action :correct_user,   only: [:edit, :update]

def index
	@user = current_user
	@users = User.all
	@book = Book.new
end

def search
	@user_or_book = params[:option]
	@select_search = params[:select]
	if @user_or_book == "1"
		@userss = User.search(params[:search], @user_or_book, @select_search)
	else
		@bookss = Book.search(params[:search], @user_or_book, @select_search)
	end

	@user = User.find(params[:id])
	@users = User.all
	@book = Book.new
	following = @user
end

def show
	@user = User.find(params[:id])
	@current_user = current_user
	gon.current_user = @current_user
	@users = User.all
	@book = Book.new
	following = @user
	@currentUserEntry = Entry.where(user_id: current_user.id)
	@userEntry = Entry.where(user_id: @user.id)
	unless @user.id == current_user.id
		@currentUserEntry.each do |cu|
			@userEntry.each do |u|
				if cu.room.id == u.room_id then
					@isRoom = true
					@roomId = cu.room_id
				end
			end
		end

	unless @isRoom
		@room = Room.new
		@entry = Entry.new
	end
    end
end

def create
    if @user.save
      NotificationMailer.send_confirm_to_user(@user).deliver
      redirect_to @user
    else
      render 'new'
    end
end


def edit
	@user = User.find(params[:id])

end

def update
	@user = User.find(params[:id])
	if @user.update(user_params)
		flash[:notice] = "User was successfully updated."
		redirect_to user_path(current_user.id)
	else
		render :edit
	end
end

private
def user_params
	params.require(:user).permit(:name, :introduction, :profile_image, :postcode, :prefecture_name, :address_city, :address_street, :address_building)
end
def correct_user
	@user = User.find(params[:id])
	unless @user == current_user
		redirect_to user_path(current_user.id)
	end
end


end