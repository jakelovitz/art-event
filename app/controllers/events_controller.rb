class EventsController < ApplicationController
  before_action :ensure_logged_in, only: %i[new show create]
  require 'rest-client'
  require 'crack'
   
  def lookup
    @locations = Event.locations
  end

  def index
  end

  def new
    @event = Event.new
    @locations = Event.locations
  end
    
  def create_from_params
    @event = Event.new(event_params)
    byebug
    #validation logic/redirects
    redirect_to @event
  end

  def show
    @event = Event.find(params[:id])
    @user_events = current_user.events.map(&:id)
  end


  # private

  def query_api_with_location
    events_hash = Event.get_nyartbeat_by_location(params)
    location = events_hash.first['Venue']['Area']
    @events = Event.where(neighborhood: location)
  end

  def event_params
    params.require(:event).permit(:event_name, :venue_name, :address, :phone, :directions, :neighborhood, :opening_hour, :closing_hour, :event_description, :img_url, :admission, :date_start, :date_end, :venue_type)
  end

end