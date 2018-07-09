class SessionsController < ApplicationController
  def new
  end

  def create
    name = params[:name]
    password = params[:password]
    user = User.find_by(name: name)

    if user && user.authenticate(password)
      session[:user_id] = user.id
      redirect_to user_path(user)
    else
      session[:error] = "Error!!!!"
      redirect_to new_session_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login'
  end
end