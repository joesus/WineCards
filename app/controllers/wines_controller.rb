class WinesController < ApplicationController
	before_action :signed_in_user, only: [:update]
	before_action :admin_user, 		 only: [:edit, :update, :destroy]

	def index
		@search = Wine.search(params[:q])
		@wines = @search.result.order("price").paginate(page: params[:page])
		@user = User.find_by(params[:remember_token])
	end

	def show
		@wine = Wine.find(params[:id])
		@comment = @wine.comments
	end

	def new
		@wine = Wine.new
	end

	def create
		@wine = Wine.new(wine_params)
		if @wine.save
			flash[:success] = "Wine added"
			redirect_to @wine
		else
			render 'new'
		end
	end

	def edit
		@wine = Wine.find(params[:id])
	end

	def update
		@wine = Wine.find(params[:id])
		if @wine.update_attributes(wine_params)
			flash[:success] = "Wine updated"
			redirect_to @wine
		else
			render 'edit'
		end
	end

	def destroy
		Wine.find(params[:id]).destroy
		flash[:success] = "Wine Deleted"
		redirect_to wines_path
	end

	def champagne
		@wines = Wine.order("price").where category: "Champagne and Sparkling Wine"
	end

  def burgundywhite
  	@wines = Wine.order("price").where category: "Burgundy, White"
  end

  def burgundyred
  	@wines = Wine.order("price").where category: "Burgundy, Red"
  end

  def bordeauxred
  	@wines = Wine.order("price").where category: "Bordeaux, Red"
  end

  def propblends
  	@wines = Wine.order("price").where category: "Proprietary Blends"
  end

  def spain
  	@wines = Wine.order("price").where category: "Spain"
  end

  def pinotnoir
  	@wines = Wine.order("price").where category: "Pinot Noir"
  end

  def cabsauv
		@wines = Wine.order("price").where category: "Cabernet Sauvignon"
  end

  def zinfandel
  	@wines = Wine.order("price").where category: "Zinfandel"
  end

  def merlot
  	@wines = Wine.order("price").where category: "Merlot"
  end

  def syrah
  	@wines = Wine.order("price").where category: "Syrah"
  end

  def rhone
  	@wines = Wine.order("price").where category: "Rhone"
  end

  def loire
  	@wines = Wine.order("price").where category: "Loire"
  end

  def chardonnay
  	@wines = Wine.order("price").where category: "Chardonnay"
  end

  def sauvblanc
  	@wines = Wine.order("price").where category: "Sauvignon Blanc"
  end

  def interestingwhites
  	@wines = Wine.order("price").where category: "Interesting Whites"
  end

  def interestingreds
  	@wines = Wine.order("price").where category: "Interesting Reds"
  end

	def italywhite
  	@wines = Wine.order("price").where category: "Italy, White"
  end

	def italyred
  	@wines = Wine.order("price").where category: "Italy, Red"
  end

  def aus_nz_white
  	@wines = Wine.order("price").where category: "Australia/New Zealand, Whites"
  end

  def aus_nz_red
  	@wines = Wine.order("price").where category: "Australia/New Zealand, Red"
  end

  def chile_arg
  	@wines = Wine.order("price").where category: "Chile/Argentina"
  end

  def half_champ_sp
  	@wines = Wine.order("price").where category: "Half Bottles, Champagne and Sparkling"
  end

  def half_white
  	@wines = Wine.order("price").where category: "Half Bottles, White"
  end

  def half_red
  	@wines = Wine.order("price").where category: "Half Bottles, Red"
  end

private

	def wine_params
		params.require(:wine).permit(:name, :varietal, :country, :vintage,
																 :description, :price, :place, :producer, :category)
	end

	def admin_user
		redirect_to(root_url) unless current_user.admin?
	end

end