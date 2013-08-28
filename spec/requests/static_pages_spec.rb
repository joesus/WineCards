require 'spec_helper'

describe "StaticPages" do
  subject { page }

  describe "Home Page" do
  	before { visit root_path }
  	it { should have_title(full_title('')) }
  	it { should_not have_title('- Home') }  	
  	it { should have_content("Howdy") }
  end

  describe "About Page" do
  	before { visit about_path }
  	it { should have_title("- About") }
  	it { should have_content("About WineCards") }
  end
end
