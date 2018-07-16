class UsersController < ApplicationController
  def index
    render json: User.all
  end

  def show
    render json: User.find(params[:id])
  end

  def create
    user = User.create(user_params)
    render json: user
  end

  def update
    User.update(user_params)
    render json: User.find(params[:id])
  end

  def destroy
    render json: User.all
  end

  private

  def user_params
    params.permit(:name)
  end
end
