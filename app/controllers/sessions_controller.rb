class SessionsController < ApplicationController

  def login
    binding.pry
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id

      render json: {message: "yayyyy"}
    else
      session[:user_id] = nil

      render json: {message: "you totally fucked up"}
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to :root
  end
end