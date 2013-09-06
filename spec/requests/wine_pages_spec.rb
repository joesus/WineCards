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

    describe "pagination" do
      
      before(:all)    { 50.times { FactoryGirl.create(:wine) } }
      after(:all)     { Wine.delete_all }

      it { should have_selector('div.pagination') }

      it "should list each wine" do
        Wine.paginate(page: 1).each do |wine|
        expect(page).to have_selector('td', text: wine.name)
        end
      end
    end

    describe "delete links" do
    
      it { should_not have_link('delete') }

      describe "as an admin user" do
        let(:admin) { FactoryGirl.create(:admin) }
        before do
          sign_in admin
          visit wines_path
        end

        # it { should have_link('delete', href: wine_path(Wine.first)) }
        # it "should be able to delete another wine" do
        #   expect do
        #     click_link('delete', match: :first)
        #   end.to change(Wine, :count).by(-1)
        # end
      end
    end
  end

  describe "show page" do
    let(:user) { FactoryGirl.create(:user) }
    let(:wine) { FactoryGirl.create(:wine) }
    let!(:c1)   { FactoryGirl.create(:comment, user_id: user.id, wine_id: wine.id, content: "Foo") }
    let!(:c2)   { FactoryGirl.create(:comment, user_id: user.id, wine_id: wine.id, content: "Bar") }

    before(:each) do 
      sign_in user
      visit wine_path(wine)
    end

    it { should have_title(full_title(wine.name)) }
    it { should have_content(wine.varietal) }
    it { should have_content(wine.price) }
    it { should have_content("Tasting Notes") }
    it { should have_content(user.name) }

    describe "comments" do
      it { should have_content(c1.content) }
      it { should have_content(c2.content) }
    end
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
          fill_in "Place",        with: "Napa Valley"
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

  
end




