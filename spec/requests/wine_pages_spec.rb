require 'spec_helper'

describe "WinePages" do
  
  subject { page }

  describe "index" do
  	let(:user) { FactoryGirl.create(:user) }
  	before(:each) do
  		sign_in user
  		visit wines_path
  	end

  	it { should have_title('All Wines') }
  	it { should have_content('All Wines') }
  end
end
