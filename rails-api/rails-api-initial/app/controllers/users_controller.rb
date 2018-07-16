class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  def index
    render json: User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    if User.exists?(params[:id])
      render json: User.find(params[:id])
    else
      render json: { :errors => "User not found" }, status: 404
    end
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    user = User.find(params[:id])

    if user.update(user_params)
      render json: user
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    user = User.find(params[:id])
    user.destroy
    render json: User.all, status: 200
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.permit(:name)
    end
end
