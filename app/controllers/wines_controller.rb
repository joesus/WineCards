class WinesController < ApplicationController
	before_action :signed_in_user, only: [:update]

	def index
		@wines = Wine.paginate(page: params[:page])
	end
	
	def show
		@wine = Wine.find(params[:id])
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



private

	def wine_params
		params.require(:wine).permit(:varietal, :country, :vintage,
																 :description, :price)
	end

end