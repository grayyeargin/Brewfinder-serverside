class ReviewsController < ApplicationController
  def create
    review = Review.create(user_id: params[:user_id], beer_id: params[:beer_id], rating: params[:rating], comment: params[:comment])
    render json: {review: review}
  end

end