class LikesController < ApplicationController
  def create
    like = Like.create(user_id: params[:user_id], beer_id: params[:beer_id])
    binding.pry
    render json: {user: user}
  end
end

