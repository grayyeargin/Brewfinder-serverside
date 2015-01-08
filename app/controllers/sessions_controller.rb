class SessionsController < ApplicationController

  def login
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      render json: {message: "yayyyy", current_user: custom_session_show(current_user)}
    else
      session[:user_id] = nil

      render json: {message: "you totally fucked up"}
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to :root
  end

  private
  def custom_session_show(user_name)
    {
      "username" => user_name.username,
      "image_url" => user_name.image_url,
      "first_name" => user_name.first_name,
      "last_name" => user_name.last_name,
      "likes" => user_name.likes.map {|like| custom_beer_show(Beer.find(like.beer_id.to_i))}
    }
  end
end