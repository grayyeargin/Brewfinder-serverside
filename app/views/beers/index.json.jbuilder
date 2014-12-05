json.array!(@beers) do |beer|
  json.extract! beer, :id, :beer, :brewery, :style, :abv
  json.url beer_url(beer, format: :json)
end
