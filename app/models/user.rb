# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  password        :string(255)
#  email           :string(255)
#  password_digest :string(255)
#  remember_token  :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#

class User < ActiveRecord::Base

	before_save { self.email = email.downcase }
	before_create :create_remember_token
	before_save { email.downcase! }

	attr_accessible :name, :email, :password, :password_confirmation
	validates(:name, presence: true)
	validates(:password, presence: true)
	validated(:email, presence: true)
	has_secure_password
	

def User.new_remember_token
	SecureRandom.urlsafe_base64
end

def User.encrypt(token)
	Digest::SHA1.hexdigest(token.to_s)
end

private
	def create_remember_token
		self.remember_token = User.encrypt(User.new_remember_token)
	end
end

# Using self ensures that assignment sets the user's remember_token and writes it
# to the database along with everything else when the user is saved.
# Without self, the assignment would create a local variable. 
