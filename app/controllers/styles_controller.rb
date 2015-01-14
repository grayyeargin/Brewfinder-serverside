class StylesController < ApplicationController

  def index
    style = Style.find_by(name: params["style"])
    total = Beer.where(style: params["style"]).where('abv > 0').count
    render json: {abv_info: abv_response(total) , style: custom_style_show(style)}
  end

  private
  def custom_style_show(style)
    {
      "name" => style.name,
      "description" => style.description,
      "beers" => Beer.where(style: params["style"]).where('avg_rating > 0').order(avg_rating: :desc).limit(10).map {|beer| custom_beer_show(beer)}
    }
  end

  def abv_response(total)
    [
      {value: "abv < 5%", count: Beer.where(style: params["style"]).where('abv > 0 AND abv < 5').count, percent: Beer.where(style: params["style"]).where('abv > 0 AND abv < 3').count / total.to_f},
      {value: "5 - 5.9", count: Beer.where(style: params["style"]).where('abv >= 5 AND abv < 6').count, percent: Beer.where(style: params["style"]).where('abv >= 3 AND abv < 5').count / total.to_f},
      {value: "6 - 6.9", count: Beer.where(style: params["style"]).where('abv >= 6 AND abv < 7').count, percent: Beer.where(style: params["style"]).where('abv >= 5 AND abv < 7').count / total.to_f},
      {value: "7 - 7.9", count: Beer.where(style: params["style"]).where('abv >= 7 AND abv < 8').count, percent: Beer.where(style: params["style"]).where('abv >= 7 AND abv < 10').count / total.to_f},
      {value: "abv >= 8%", count: Beer.where(style: params["style"]).where('abv > 8').count, percent: Beer.where(style: params["style"]).where('abv > 8').count / total.to_f}
    ]
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