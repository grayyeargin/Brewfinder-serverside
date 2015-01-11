class ReviewsController < ApplicationController
  def create
    review = Review.create(user_id: params[:user_id], beer_id: params[:beer_id], rating: params[:rating], comment: params[:comment])
    beer = Beer.find(params[:beer_id])
    if beer.avg_rating
      new_avg = ((beer.avg_rating * beer.rating_no || 0) + params[:rating]) / ((beer.rating_no || 0) + 1)
      beer.update(rating_no: beer.rating_no + 1, avg_rating: new_avg)
    else
      beer.update(rating_no: 1, avg_rating: params[:rating])
    end
    render json: {review: review}
  end

end