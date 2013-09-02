require 'spec_helper'

describe "WinePages" do
  
  subject { page }

  describe "show page" do
    let(:wine) { FactoryGirl.create(:wine) }
    before { visit wine_path(wine) }

    it { should have_content(wine.varietal) }
    it { should have_content(wine.price) }
    it { should have_content("Tasting Notes") }
  end

  describe "adding a wine" do
    
    describe "when not signed in" do

    end
    
    describe "when signed in" do
      
    end
  end

  describe "index" do
  	let(:user) { FactoryGirl.create(:user) }
  	before(:each) do
  		sign_in user
  		visit wines_path
  	end

  	it { should have_title('All Wines') }
  	it { should have_content('All Wines') }
    it { should have_link('Add a Wine') }
  end
end
