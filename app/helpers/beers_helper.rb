module BeersHelper

  def custom_beer_show(beer_name)
      {
        "id" => beer_name.id,
        "name" => beer_name.name,
        "style" => beer_name.style,
        "image" => beer_name.image,
        "brewery_name" => beer_name.brewery.name,
        "brewery_id" => beer_name.brewery.id
      }
  end


end
