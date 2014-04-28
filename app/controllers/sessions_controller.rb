class SessionsController < ApplicationController
  before_action :require_user, only: [:destroy]
  
  def new
  end

  def create
    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = "Welcome back #{user.username}. You are now logged in."
      redirect_to root_path
    else
      flash[:error] = "There is something wrong with your username or password"
      redirect_to login_path
    end
  end

  def destroy
    flash[:notice] = "Good bye #{current_user.username}. You are now logged out"
    session[:user_id] = nil
    redirect_to root_path
  end

end