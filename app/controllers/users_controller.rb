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
    set_user
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
end
