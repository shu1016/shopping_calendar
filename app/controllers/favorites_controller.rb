class FavoritesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event

  def create
    favorite = current_user.favorites.build(event_id: params[:event_id])
    favorite.save
    render partial: 'favorites/eventsindex', locals: { event: @event }
  end

  def destroy
    favorite = Favorite.find_by(event_id: params[:event_id], user_id: current_user.id )
    if favorite.present?
      favorite.destroy
      if params[:redirection] == 'user'
        redirect_to user_path(current_user)
      else
        render partial: 'favorites/eventsindex', locals: { event: @event }
      end
    else
      redirect_to user_path(current_user)
    end
  end

  def set_event
    @event = Event.find(params[:event_id])
  end


end
