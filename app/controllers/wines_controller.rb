class WinesController < ApplicationController
	before_action :signed_in_user, only: [:update]
	before_action :admin_user, 		 only: [:edit, :update, :destroy]

	def index
		@search = Wine.search(params[:q])
		@wines = @search.result.paginate(page: params[:page])
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


private

	def wine_params
		params.require(:wine).permit(:name, :varietal, :country, :vintage,
																 :description, :price, :place, :producer)
	end

	def admin_user
		redirect_to(root_url) unless current_user.admin?
	end

end