class UsersController < ApplicationController
	before_action :signed_in_user, only: [:edit, :update]
	before_action :correct_user, 	 only: [:edit, :update]
	before_action :admin_user,		 only: [:destroy, :index]


	def index
    @users = User.paginate(page: params[:page])
# Paginate method basically just returns the 30 entries at a time
	end
	
	def show
		@user = User.find(params[:id])
		@comments = @user.comments.paginate(page: params[:page])
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

	def destroy
		User.find(params[:id]).destroy
		flash[:success] = "User destroyed."
		redirect_to users_url
	end

private 

	def user_params
		params.require(:user).permit(:name, :email, :password,
																 :password_confirmation)
	end
# Defining params like this keeps people from passing malicious content
# into your site.

	# Before filters

	def correct_user
		@user = User.find(params[:id])
		redirect_to(root_url) unless current_user?(@user)
	end
# current_user? boolean is defined in the SessionsHelper

	def admin_user
		redirect_to(root_url) unless current_user.admin?
	end
end
