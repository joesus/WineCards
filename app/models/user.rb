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
#  admin           :boolean          default(FALSE)
#

class User < ActiveRecord::Base
	has_many :comments, dependent: :destroy
	has_many :wines

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
# Copied Standard Regex for Standard Email
	before_create :create_remember_token
	before_save { self.email = email.downcase }
#	Same as: before_save { self.email = email.downcase }
# Necessary b/c db is case sensitive
# These before_action hooks are callbacks that trigger logic before or
# after an alteration of the object state.
  attr_accessible :name, :email, :password, :password_confirmation, :admin
	
	validates :name, presence: true, length: { maximum: 50 }
# Requires a name, with max length 50
	validates :password, presence: true, length: { minimum: 6 }
# Requires a password, maybe presence not necessary b/c of has_secure_password
	validates :email, presence: true,
						format: { with: VALID_EMAIL_REGEX },
						uniqueness: { case_sensitive: false }
# Not sure why uniqeness here. 
	has_secure_password
# adding has_secure_password gives us the authenticate methods. 
	

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
