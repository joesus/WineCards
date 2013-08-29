class UsersController < ApplicationController

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
			flash[:success] = "Welcome to Winecards!"
			redirect_to @user
		else
			render 'new'
		end
	end

	def user_params
		params.require(:user).permit(:name, :email, :password,
																 :password_confirmation)
	end
# Defining params like this keeps people from passing malicious content
# into your site.

	def index
    @users = User.paginate(page: params[:page])
  end
end
