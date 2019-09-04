class UserEventsController < ApplicationController
  before_action :ensure_logged_in, only: :create
  # before_action :ensure_validated, only: %i[create]

  def create
    user_id = current_user.id
    event_id = params[:event_id]
    if UserEvent.create(user_id: user_id, event_id: event_id)
      redirect_to user_path(user_id)
    else
      flash[:errors] = "Something went wrong"
    end
  end

  def destroy
    user_id = current_user.id
    event_id = params[:event_id].to_i
    ue_id = UserEvent.find_by(user_id: user_id, event_id: event_id)
    UserEvent.destroy(ue_id.id)
      redirect_to user_path(user_id)
  end

end