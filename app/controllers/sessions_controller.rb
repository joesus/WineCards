class SessionsController < ApplicationController

	def new
	end

	def create
		user = User.find_by(email: params[:session][:email].downcase)
# So find the user using the email that was just stored as a value 
# in the nested hash and save it as the value of user. 
		if user && user.authenticate(params[:session][:password])
# Compare the value of the email you just saved to the value of the
# same that undergoes the authenticate method (which i don't yet comprehend)
			sign_in user
			redirect_to user
		else
			flash.now[:error] = 'Invalid email/password combination'
# The .now helps it only persist for one http request.
			render 'new'
		end
	end

	def destroy
		sign_out
		redirect_to root_url
	end
end
