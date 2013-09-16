class WinePagesController < ApplicationController

  def interesting_reds
  	@wine = Wine.find_by category: "Interesting Reds"
  end

  def spain
  	@wines = Wine.where category: "Spain"
  end
end
