require 'spec_helper'

describe "WinePages" do
  
  subject { page }

  describe "show page" do
    let(:wine) { FactoryGirl.create(:wine) }
    before { visit wine_path(wine) }

    it { should have_title(wine.name) }
    it { should have_content(wine.varietal) }
    it { should have_content(wine.price) }
    it { should have_content("Tasting Notes") }
  end

  describe "adding a wine" do

# No test for when not signed in b/c link to add should only
# appear from user profile.

    describe "when signed in" do
      before { visit new_wine_path }

      let(:submit) { "Add Wine" }

      describe "with invalid information" do
        it "should not create a wine" do
          expect { click_button submit }.not_to change(Wine, :count)
        end

        describe "after submission" do
          before { click_button submit }

          it { should have_title('Add a Wine') }
          it { should have_content('error') }
        end
      end

      describe "with valid information" do
        before do
          fill_in "Name",         with: "Joe's Wine"
          fill_in "Varietal",     with: "Merlot"
          fill_in "Country",      with: "America"
          fill_in "Vintage",      with: 2001
          fill_in "Description",  with: "Tasty"
          fill_in "Price",        with: 150
        end

        it "should create a wine" do
          expect { click_button submit }.to change(Wine, :count).by(1)
        end
      end
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
