class EventsController < ApplicationController
  before_action :ensure_logged_in, only: %i[new show create]
  before_action :check_created_by_user, only: %i[edit update destroy]
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
    
  def create
    @event = Event.new(event_params)
    if @event.valid?
      @event.save
      @usercreateevent = UserCreateEvent.create(event_id: @event.id, user_id: current_user.id)
      redirect_to @event
    else
      flash[:errors] = @event.errors.full_messages
      @locations = Event.locations
      render :new
    end
  end

  def show
    @event = Event.find(params[:id])
    @user_events = current_user.events.map(&:id)
    @usercreateevent = UserCreateEvent.find_by(event_id: @event.id, user_id: current_user.id)
  end

  def edit
    @locations = Event.locations
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      @event.update(event_params)
      redirect_to @event
    else
      flash[:errors] = @event.errors.full_messages
      @locations = Event.locations
      render :edit
    end
  end

  def destroy
    user_id = current_user.id
    @event = Event.find(params[:id])
    @usercreateevent = UserCreateEvent.find_by(event_id: @event.id, user_id: current_user.id)
    @event.destroy
      redirect_to user_path(user_id)
  end
  
  def query_api_with_location
    events_hash = Event.get_nyartbeat_by_location(params)
    location = events_hash.first['Venue']['Area']
    @events = if params['Filter Free']
                Event.where(neighborhood: location, free: true)
              else
                Event.where(neighborhood: location)
              end
  end
  
  private

  def check_created_by_user
    @event = Event.find(params[:id])
    @usercreateevent = UserCreateEvent.find_by(event_id: @event.id, user_id: current_user.id)
    if @usercreateevent.nil?
      flash[:notice] = "You can't edit this event."
      redirect_to user_path(current_user)
    else
    end
  end

  def event_params
    params.require(:event).permit(:event_name, :venue_name, :address, :phone, :directions, :neighborhood, :opening_hour, :closing_hour, :event_description, :img_url, :admission, :date_start, :date_end, :venue_type, :image, :filter_free)
  end
end