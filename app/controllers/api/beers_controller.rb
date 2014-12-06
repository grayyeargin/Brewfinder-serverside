class Api::BeersController < ApplicationController
  before_action :set_beer, only: [:show, :edit, :update, :destroy]

  # GET /beers
  # GET /beers.json
  def index
    @beers = Beer.query(options["query"]).style(options["style"]).max_abv(options["max_abv"]).min_abv(options["min_abv"])
    render json: custom_beer_show(@beers)
  end

  # GET /beers/1
  # GET /beers/1.json
  def show
    beer = Beer.find(params[:id])
    render json: custom_beer_show(beer)
  end

  # GET /beers/new
  def new
    @beer = Beer.new
  end

  # GET /beers/1/edit
  def edit
  end

  # POST /beers
  # POST /beers.json
  def create
    @beer = Beer.new(beer_params)

    respond_to do |format|
      if @beer.save
        format.html { redirect_to @beer, notice: 'Beer was successfully created.' }
        format.json { render :show, status: :created, location: @beer }
      else
        format.html { render :new }
        format.json { render json: @beer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /beers/1
  # PATCH/PUT /beers/1.json
  def update
    respond_to do |format|
      if @beer.update(beer_params)
        format.html { redirect_to @beer, notice: 'Beer was successfully updated.' }
        format.json { render :show, status: :ok, location: @beer }
      else
        format.html { render :edit }
        format.json { render json: @beer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /beers/1
  # DELETE /beers/1.json
  def destroy
    @beer.destroy
    respond_to do |format|
      format.html { redirect_to beers_url, notice: 'Beer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_beer
      @beer = Beer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def beer_params
      params.require(:beer).permit(:beer.string, :brewery.string, :style.string, :abv.string)
    end

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


    def options
      defaults.merge(params)
    end

    def defaults
      {"query" => "", "style" => "", "max_abv" => "100", "min_abv" => "0"}
    end

end
