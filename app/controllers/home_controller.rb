class HomeController < ApplicationController
  def index
    if !session[:user_id].nil?
      @user = User.find(session[:user_id])
      @owned_stocks = @user.stocks_ownership
    end
  end
end
