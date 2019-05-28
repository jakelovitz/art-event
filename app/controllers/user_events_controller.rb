class UserEventsController < ApplicationController

  def create
    user_id = current_user.id
    event_id = params[:event_id]
    if UserEvent.create(user_id: user_id, event_id: event_id)
      redirect_to user_path(user_id)
    else
      flash[:errors] = "Something went wrong"
    end
  end

end