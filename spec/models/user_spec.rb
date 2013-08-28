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

require 'spec_helper'

describe User do
  
  before do
  	@user = User.new(name: "Joe S", email: "joe@joe.com", password: "foobar",
  						password_confirmation: "foobar")
  end

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
# The password digest is created by the bcrypt gem and is essentially a hash 
# that holds the encrypted password. 
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:authenticate) }

  it { should be_valid }

# Name Test

  describe "when name is not present" do
    before { @user.name = " " }
    it { should_not be_valid }
  end

# Email Test

  describe "email address with mixed case" do
    let(:mixed_case_email) { "Foo@ExAMple.Com" }

    it "should be saved as all lower-case" do
      @user.email = mixed_case_email
      @user.save
      expect(@user.reload.email).to eq mixed_case_email.downcase
    end
  end

# Password Test

  describe "when password is not present" do
    before do
      @user = User.new(name: "Joe S", email: "Joe@joe.com", password: " ", 
        password_confirmation: " ")
    end

    it { should_not be_valid }
  end

  describe "when a password is too short" do
    before { @user.password = @user.password_confirmation = "a" * 5 }
    it { should be_invalid }
  end

  describe "when password doesn't match confirmation" do
    before { @user.password_confirmation = "mismatch" }
# This works because of the has_secure_password line in the model. 
    it { should_not be_valid }
  end

# Authentication Tests

  describe "return value of authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by(email: @user.email) }

    describe "with valid password" do
      it { should eq found_user.authenticate(@user.password) }
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it { should_not eq user_for_invalid_password }
      specify { expect(user_for_invalid_password).to be_false }
    end
  end
end







