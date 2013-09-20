class CommentsController < ApplicationController
	before_action :signed_in_user, only: [:create, :destroy]

  def create
    @wine = Wine.find(params[:wine_id])
    @comment = @wine.comments.build(comment_params)
  	@comment.user_id = current_user.id
    if @comment.save
  		flash[:success] = "Comment Saved"
      redirect_to wine_path(@wine)
  	else
  		flash[:danger] = "There were errors with your submission"
      redirect_to wine_path(@wine)
  	end
  end

  def destroy
    @comment.destroy
    redirect_to root_url
  end

  def new
    @user = current_user
    @wine = Wine.find(params[:wine_id])
    @comment = @user.comments.build
  end

  private

  	def comment_params
  		params.require(:comment).permit(:content, :user_id, :wine_id)
  	end
end