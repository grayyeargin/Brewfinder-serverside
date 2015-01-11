class FollowsController < ApplicationController
  def create
    follow = Follow.create(user_id: params[:user_id], beer_id: params[:following_id])
    render json: {review: review}
  end

end