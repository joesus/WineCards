require 'spec_helper'

describe "Views" do
  
  subject { page }

  describe "Category Views" do
    let(:user) { FactoryGirl.create(:user) }
    before(:each) do
      sign_in user
    end

    describe "Champagne Page" do
      before { visit champagne_path }

      it { should have_content('Champagne and Sparkling Wine') }
    end

    describe "Burgundy White Page" do
      before { visit burgundywhite_path }
      it { should have_content('Burgundy, White') }
    end

    describe "Burgundy Red Page" do
      before { visit burgundyred_path }
      it { should have_content('Burgundy, Red') }
    end

    describe "Bordeaux Red Page" do
      before { visit bordeauxred_path }
      it { should have_content('Bordeaux, Red') }
    end

    describe "Proprietary Blend Page" do
      before { visit propblends_path }
      it { should have_content('Proprietary Blends') }
    end

    describe "Spain Page" do
      before { visit spain_path }
      it { should have_content('Spain') }
    end

    describe "Pinot Noir" do
      before { visit pinotnoir_path }
      it { should have_content('Pinot Noir') }
    end

    describe "Cabernet Sauvignon Page" do
      before { visit cabsauv_path }
      it { should have_content('Cabernet Sauvignon') }
    end

    describe "Merlot Page" do
      before { visit merlot_path }
      it { should have_content('Merlot') }
    end    

    describe "Syrah Page" do
      before { visit syrah_path }
      it { should have_content('Syrah') }
    end    

    describe "Rhone Page" do
      before { visit rhone_path }
      it { should have_content('Rhone') }
    end    

    describe "Loire Page" do
      before { visit loire_path }
      it { should have_content('Loire') }
    end    

    describe "Chardonnay Page" do
      before { visit chardonnay_path }
      it { should have_content('Chardonnay') }
    end    

    describe "Sauvignon Blanc Page" do
      before { visit sauvblanc_path }
      it { should have_content('Sauvignon Blanc') }
    end

    describe "Interesting Whites Page" do
      before { visit intwhites_path }
      it { should have_content('Interesting Whites') }
    end    

    describe "Interesting Reds Page" do
      before { visit intreds_path }
      it { should have_content('Interesting Reds') }
    end    

    describe "Italy White Page" do
      before { visit italywhite_path }
      it { should have_content('Italy, White') }
    end 

    describe "Italy Red Page" do
      before { visit italyred_path }
      it { should have_content('Italy, Red') }
    end 

    describe "Australia NZ White Page" do
      before { visit aus_nz_white_path }
      it { should have_content('Australia/New Zealand, Whites') }
    end 

    describe "Australia NZ Red Page" do
      before { visit aus_nz_red_path }
      it { should have_content('Australia/New Zealand, Reds') }
    end 

    describe "Chile Argentina Page" do
      before { visit chile_arg_path }
      it { should have_content('Chile Argentina') }
    end 

    describe "Half Bottles Champagne Page" do
      before { visit half_champ_sp_path }
      it { should have_content('Loire') }
    end

    describe "Half Bottles Red Page" do
      before { visit half_red_path }
      it { should have_content('Half Bottles, Red') }
    end 

    describe "Half Bottles White Page" do
      before { visit half_white_path }
      it { should have_content('Half Bottles, White') }
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
          fill_in "Producer",     with: "Susnick Vineyards"
          fill_in "Name",         with: "Joe's Wine"
          fill_in "Varietal",     with: "Merlot"
          fill_in "Place",        with: "Napa Valley"
          fill_in "Country",      with: "America"
          fill_in "Vintage",      with: 2001
          fill_in "Description",  with: "Tasty"
          fill_in "Price",        with: 150
          fill_in "Category",     with: "Spain"
        end

        it "should create a wine" do
          expect { click_button submit }.to change(Wine, :count).by(1)
        end
      end
    end
  end

  describe "edit" do
    let(:admin) { FactoryGirl.create(:admin) }
    let(:wine)  { FactoryGirl.create(:wine) }
    before do
      sign_in admin
      visit edit_wine_path(wine)
    end

    describe "page" do
      it { should have_content("Edit Wine") }
      it { should have_title("Edit Wine")}
    end

    describe "with invalid information" do
      let(:new_varietal)  { " " }
      let(:new_country)   { " " }
      let(:new_place)     { " " }
      before do
        fill_in "Varietal",     with: new_varietal
        fill_in "Country",      with: new_country
        fill_in "Place",        with: new_place
        click_button "Save changes"
      end

      it { should have_content('error') }
    end

    describe "with valid information" do
      let(:new_varietal) { "Merlot" }
      let(:new_country)  { "France" }
      let(:new_place)    { "Bordeaux" }
      before do
        fill_in "Varietal",     with: new_varietal
        fill_in "Country",      with: new_country
        fill_in "Place",        with: new_place
        click_button "Save changes"
      end

      it { should have_content(new_varietal) }
      it { should have_content(new_country) }
      it { should have_content(new_place) }
      it { should have_selector('div.alert.alert-success') }
    end
  end
end




