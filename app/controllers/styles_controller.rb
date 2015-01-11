class StylesController < ApplicationController

  def index
    style = Style.find_by(name: params["style"])
    render json: {style: custom_style_show(style)}
  end

  private
  def custom_style_show(style)
    {
      "name" => style.name,
      "description" => style.description,
      "beers" => Beer.where(style: params["style"]).where('avg_rating > 0').order(avg_rating: :asc).limit(10).map {|beer| custom_beer_show(beer)}
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
      "brewery_id" => beer_name.brewery.id,
      "rating_no" => beer_name.rating_no,
      "avg_rating" => beer_name.avg_rating
    }
  end

end