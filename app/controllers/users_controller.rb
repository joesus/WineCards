class UsersController < ApplicationController
	before_action :signed_in_user, only: [:edit, :update]
	before_action :correct_user, 	 only: [:edit, :update]


	def index
    @users = User.paginate(page: params[:page])
	end
	
	def show
		@user = User.find(params[:id])
	end

	def new
		@user = User.new
	end
# Corresponds to the form in the new view.

	def create
		@user = User.new(user_params)
# We used to pass new(params[:user]) which defined params as a 
# hash of hashes for the user object. Eq to saying 
# @user = User.new(name: "joe", email: "joe@"... etc.) but it was insecure 
# so instead now we define the params we want to be accessible and required.
		if @user.save			
# Handles a successful save
			sign_in @user
			flash[:success] = "Welcome to Winecards!"
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
		if @user.update_attributes(user_params)
			flash[:success] = "Profile updated"
			sign_in @user
			redirect_to @user
		else
			render 'edit'
		end
	end
	
private 

	def user_params
		params.require(:user).permit(:name, :email, :password,
																 :password_confirmation)
	end
# Defining params like this keeps people from passing malicious content
# into your site.

	# Before filters

	def signed_in_user
		unless signed_in?
			store_location
			redirect_to signin_url, notice: "Please sign in." unless signed_in?
		end
	end
# Here notice: is short for flash[:notice] = "Please..."

	def correct_user
		@user = User.find(params[:id])
		redirect_to(root_url) unless current_user?(@user)
	end
# current_user? boolean is defined in the SessionsHelper
end
