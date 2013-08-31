module SessionsHelper

	def sign_in(user)
		remember_token = User.new_remember_token
# Creates a new token, sets it as remember_token
		cookies.permanent[:remember_token] = remember_token
# Places the unencrypted token in the browser cookies
		user.update_attribute(:remember_token, User.encrypt(remember_token))
# Saves the encrypted token to the database.
		self.current_user = user
# Sets the current_user as defined below equal to the given user.
# Lets us access current_user in controllers and views. 
# The self is necessary so that ruby doesn't make a local variable called current_user.
	end

	def current_user=(user)
		@current_user = user
	end
# Basically the code self.current_user = ... is automatically converted to
# current_user=(...) Basically this sets the current user to user.

	def current_user
		remember_token = User.encrypt(cookies[:remember_token])
# Finds the encrypted remember_token for the user
		@current_user ||= User.find_by(remember_token: remember_token)
# Returns the current user unless that is undefined in which case it uses
# find_by method to go into the database and return the user. 
	end

	def current_user?(user)
		user == current_user
	end

	def signed_in?
		!current_user.nil?
	end

	def signed_in_user
		unless signed_in?
			store_location
			redirect_to signin_url, notice: "Please sign in." unless signed_in?
		end
	end
# Here notice: is short for flash[:notice] = "Please..."

	def sign_out
		self.current_user = nil
		cookies.delete(:remember_token)
	end

	def redirect_back_or(default)
		redirect_to(session[:return_to] || default)
		session.delete(:return_to)
	end

	def store_location
		session[:return_to] = request.url
# Storage mechanism is the session facility provided by rails,
# automatically expires upon browser close.
# This puts the requested URL in the session variable under the key :return_to
	end	
end





