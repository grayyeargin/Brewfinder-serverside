class LikesController < ApplicationController
  def create
    like = Like.create(user_id: params[:user_id], beer_id: params[:beer_id])
    beer = Beer.find(params[:beer_id])
    beer.update(like_no: beer.like_no + 1)
    user = User.find(params[:user_id])
    render json: {user: custom_user_show(user)}
  end

  private
  def custom_user_show(user_name)
      {
        "username" => user_name.username,
        "image_url" => user_name.image_url,
        "first_name" => user_name.first_name,
        "last_name" => user_name.last_name,
        "likes" => user_name.likes.map {|like| custom_beer_show(Beer.find(like.beer_id.to_i))}
      }
  end
  def custom_beer_show(beer_name)
    {
      "id" => beer_name.id,
      "name" => beer_name.name,
      "abv" => beer_name.abv,
      "style" => beer_name.style,
      "image" => beer_name.image,
      "description" => beer_name.description,
      "brewery_name" => beer_name.brewery.name,
      "brewery_id" => beer_name.brewery.id
    }
  end
end

