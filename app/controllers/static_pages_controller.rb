class StaticPagesController < ApplicationController

  def home
    @user = current_user
    if signed_in?
  	  @comment = current_user.comments.build
			redirect_to user_path(@user)
  	end
  end

  def help
  end

  def contact
  end

  def about
  end

end
