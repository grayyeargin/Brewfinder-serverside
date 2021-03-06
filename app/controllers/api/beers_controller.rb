class Api::BeersController < ApplicationController
  before_action :set_beer, only: [:show, :edit, :update, :destroy]


  def index
    total_beers = Beer.query(options["query"]).style(options["style"]).max_abv(options["max_abv"]).min_abv(options["min_abv"]).order(updated_at: :desc)
    total = total_beers.count
    total_pages = (total/50).ceil
    paginated = total_beers.paginate(:page => params[:page], :per_page => 50)
    beers = paginated.map {|beer| custom_beer_show(beer)}
    render json: {"total" => total, "count" => 50, "total_pages" => total_pages, "beers" => beers}
  end

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
    beer = Beer.create(beer_params)
    render json: beer
  end

  # PATCH/PUT /beers/1
  # PATCH/PUT /beers/1.json
  def update
    beer = Beer.find(params[:id])
    beer.update(beer_params)
    render json: beer
  end

  # DELETE /beers/1
  # DELETE /beers/1.json
  def destroy
    set_beer
    beer = @beer.destroy!
    render json: beer
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_beer
      @beer = Beer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def beer_params
      params.require(:beer).permit(:name, :brewery_id, :style, :abv, :description, :image)
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
        "avg_rating" => beer_name.avg_rating,
        "rating_no" => beer_name.rating_no,

      }
    end

    def custom_review_show(review)
      {
        "user" => review.user.username,
        "rating" => review.rating,
        "user_image" => review.user.image_url,
        "comment" => review.comment
      }
    end


    def options
      defaults.merge(params)
    end

    def defaults
      {"query" => "", "style" => "", "max_abv" => "100", "min_abv" => "0"}
    end

end
