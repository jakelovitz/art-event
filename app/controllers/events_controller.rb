class EventsController < ApplicationController
  before_action :ensure_logged_in, only: %i[new create]
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
  end


  # private

  def query_api_with_location
    events_hash = Event.get_nyartbeat_by_location(params)
    location = events_hash.first['Venue']['Area']
    @events = Event.where(neighborhood: location)
  end

end