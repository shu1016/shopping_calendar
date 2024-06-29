class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    favorite = current_user.favorites.build(event_id: params[:event_id])
    favorite.save
    redirect_to events_path
  end

  def destroy
    favorite = Favorite.find_by(event_id: params[:event_id], user_id: current_user.id )
    favorite.destroy
    if params[:redirection] == 'user'
      redirect_to user_path(current_user)
    else
      redirect_to events_path
    end
  end


end
