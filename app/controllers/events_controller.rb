class EventsController < ApplicationController
  require 'rest-client'
  require 'crack'
   
  def lookup
    @locations = Event.locations
  end

  def index
  end

  def new; end
    
  def create; end

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

end