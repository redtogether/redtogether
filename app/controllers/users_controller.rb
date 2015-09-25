class UsersController < ApplicationController
  def show
    @user = User.find_by_param(params[:id])
    render json: @user, only: %i( handle created_at )
  end
end
