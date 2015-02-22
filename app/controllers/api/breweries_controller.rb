class Api::BreweriesController < ApplicationController
  before_action :set_brewery, only: [:show, :edit, :update, :destroy]

  def index
    @breweries = Brewery.query(options["query"])
    render json: @breweries
  end


  def show
    @brewery = Brewery.find(params[:id])
    render json: custom_brewery_show(@brewery)
  end


  # def new
  #   @brewery = Brewery.new
  # end


  # def edit
  # end


  def create
    @brewery = Brewery.create(brewery_params)
    render json: @brewery
  end


  def update
    brewery = Brewery.find(params[:id])
    brewery.update(brewery_params)
    render json: brewery
  end


  def destroy
    brewery = Brewery.find(params[:id])
    brewery
  end

  private

    def set_brewery
      @brewery = Brewery.find(params[:id])
    end


    def brewery_params
      params.require(:brewery).permit(:name, :location, :url)
    end

    def custom_brewery_show(brewery_name)
      {
        "name" => brewery_name.name,
        "location" => brewery_name.location,
        "url" => brewery_name.url,
        "id" => brewery_name.id,
        "image" => brewery_name.image_url,
        "address" => brewery_name.address,
        "phone_number" => brewery_name.phone_number,
        "longitude" => brewery_name.longitude,
        "latitude" => brewery_name.latitude,
        "beer_selection" => brewery_name.beers.map {|beer| {"name" => beer.name, "style" => beer.style, "abv" => beer.abv, "beer_id" => beer.id}}
      }
    end

    def options
      defaults.merge(params)
    end

    def defaults
      {"query" => "", "location" => ""}
    end

end
