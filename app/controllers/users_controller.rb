class UsersController < ApplicationController

  before_action :authenticate_user!, only: [:new, :edit, :destroy]
  before_action :set_user, only: [:edit, :show, :update]
  before_action :move_to_index, only: [:edit, :show]
  

  def index
    @events = Event.all
    @favorites = current_user.favorites
  end

  def show
    @events = current_user.events
    @favorites = current_user.favorites

    favorites = Favorite.where(user_id: current_user.id).pluck(:event_id)
    @favrite_list = Event.find(favorites)
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(current_user)
    else
      render :show, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:nickname, :email, :region_id, :city)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def move_to_index
    if current_user != @user
      redirect_to users_path
    end
  end


end
