class UsersController < ApplicationController

  before_action :set_user, only: :show
  before_action :move_to_index, only: :show
  

  def index
    @events = Event.all
    @favorites = current_user.favorites
  end

  def show
    @events = current_user.events.order(:start_time)
    @favorites = current_user.favorites.includes(:event).order('events.start_time')
  end


  private

  def set_user
    @user = User.find(params[:id])
  end

  def move_to_index
    if current_user != @user
      redirect_to users_path
    end
  end


end
