# == Schema Information
#
# Table name: wines
#
#  id          :integer          not null, primary key
#  varietal    :string(255)
#  country     :string(255)
#  vintage     :integer
#  description :string(255)
#  price       :integer
#  created_at  :datetime
#  updated_at  :datetime
#  name        :string(255)
#

require 'spec_helper'

describe Wine do

	before do
		@wine = Wine.new(name: "Mr. Joe's Wine", varietal: "grape", 
										 country: "wineland", vintage: 2000, description: "tasty", 
										 price: 200)
 	end

 	subject { @wine }

 	it { should respond_to(:name) }
 	it { should respond_to(:varietal) }
 	it { should respond_to(:country) }
 	it { should respond_to(:vintage) }
 	it { should respond_to(:description) }
 	it { should respond_to(:price) }

	describe "when varietal is not present" do
		before { @wine.varietal = " " }
		it { should_not be_valid }
	end

	describe "when varietal name is too long" do
		before { @wine.varietal = "a" * 76 }
		it { should_not be_valid }
	end

	describe "when country is not present" do
		before { @wine.country = " " }
		it { should_not be_valid }
	end

	describe "when country name is too long" do
		before { @wine.country = "a" * 21 }
		it { should_not be_valid }
	end

	describe "with a description that's too long" do
		before { @wine.description = "a" * 201 }
		it { should_not be_valid }
	end

	describe "a price that is a string" do
		before { @wine.price = "string" }
		it { should_not be_valid }
	end
end