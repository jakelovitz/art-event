class UserEventsController < ApplicationController
  before_action :ensure_logged_in, only: :create

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