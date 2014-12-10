class BreweriesController < ApplicationController
  before_action :set_brewery, only: [:show, :edit, :update, :destroy]

  def index
    @breweries = Brewery.all
  end


  def show
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
end
