class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    render json: custom_user_show(@user)
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    set_user
  end

  # POST /users
  # POST /users.json
  def create
    user = User.create(user_params)
    binding.pry
    if user.valid?
       render json: {user: user}
    else
      @errors = user.errors.full_messages
      @user = User.new
      render "new"
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    set_user
    @user.update(user_params)
    redirect_to user
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    set_user
    @user.destroy!
    redirect_to :root
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:username, :password, :image_url, :first_name, :last_name)
    end

    def custom_user_show(user_name)
      {
        "username" => user_name.username,
        "image_url" => user_name.image_url,
        "first_name" => user_name.first_name,
        "last_name" => user_name.last_name,
        "likes" => user_name.likes.map {|like| custom_beer_show(Beer.find(like.beer_id.to_i))},
        "reviews" => user_name.reviews.map {|review| custom_review_show(review)}
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

    def custom_review_show(review)
      {
        "beer" => review.beer.name,
        "style" => review.beer.style,
        "image" => review.beer.image,
        "beer_id" => review.beer_id,
        "rating" => review.rating,
        "comment" => review.comment
      }
    end

end
