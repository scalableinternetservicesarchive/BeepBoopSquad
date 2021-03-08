class SessionsController < ApplicationController
  skip_forgery_protection
  #https://medium.com/@wintermeyer/authentication-from-scratch-with-rails-5-2-92d8676f6836
  def new
  end

  def create
    user = User.find_by_name(params[:name])
    if user && user.password == params[:password]
      session[:user_id] = user.id
      redirect_to root_url, notice: "Logged in!"
    else
      flash.now[:alert] = "Email or password is invalid"
      redirect_to root_path, notice: "Login failed. Moron."
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Logged out!"
  end
end
