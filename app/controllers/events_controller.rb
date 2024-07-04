class EventsController < ApplicationController
  
  before_action :authenticate_user!, only: [:new, :edit, :destroy]
  before_action :set_event, only: [:edit, :update, :destroy]
  before_action :move_to_index, only: [:edit, :destroy]


  def index
    @q = Event.includes(:user).where('end_time >= ?', DateTime.now.beginning_of_day).ransack(params[:q])
    @events = @q.result(distinct: true).order(:start_time)
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to users_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @event.update(event_params) 
      redirect_to user_path(current_user)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @event.destroy
    redirect_to user_path(current_user)
  end

  def search
    @q = Event.ransack(search_params)
    @events = @q.result(distinct: true).includes(:user).where('start_time >= ?', DateTime.now.beginning_of_day).order(:start_time)
  end


  private
  def event_params
    params.require(:event).permit(:title, :start_time, :end_time, :content).merge(user_id: current_user.id)
  end

  def set_event
    @event = Event.find(params[:id])
  end

  def move_to_index
    if current_user != @event.user
      redirect_to users_path
    end
  end

  def search_params
    params.require(:q).permit(:user_region_id_eq, :user_city_cont)
  end

end
