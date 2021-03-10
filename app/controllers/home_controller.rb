class HomeController < ApplicationController
  caches_page :index
  
  def index
  	if current_user
  		@portfolio_history = PortfolioValueHistory.where("user_id = ?", current_user.id).select(:created_at, :portfolio_value)
  	end
  end
end
