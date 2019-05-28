class EventsController < ApplicationController
	require "rest-client"
	require "crack"


    def lookup
        @locations = Event.locations
    end

    def index
    end

    def new
    end

		def query_api_with_location
			@neighborhood = Event.get_nyartbeat_by_location(params)
        byebug
		end
		
		def create
		end

    def show
    end

    def display_api_event
      @all_events.each do |event|
        temp_event = Event.new(event_name: event)
        temp_event.event_name = event['Name']
        temp_event.venue_name = event['Venue']['Name']
        temp_event.address = event['Venue']['Address']
        temp_event.phone = event['Venue']['Phone']
        temp_event.directions = event['Venue']['Access']
        temp_event.neighborhood = event['Venue']['Area']
        temp_event.opening_hour = event['Venue']['OpeningHour']
        temp_event.closing_hour = event['Venue']['ClosingHour']
        temp_event.event_description = event['Description']
        temp_event.img_url = event['Image'].last['src'].chomp("-170")
        temp_event.admission = event['Price']
        temp_event.date_start = event['DateStart']
        temp_event.date_end = event['DateEnd']
        temp_event.api_id = event['id']
        temp_event.venue_type = event['Venue']['Type']
      end
    end

    def fetch_events(location)
      @all_events = []
      api = query_api_with_location(location)['Events']['Event']
      api.each do |event|
        @all_events << event
      end
      @all_events
    end

    # def fetch_event_name
    #   @event_value.each do |event|
    #     event['Name']

    # end

    private

end
= event['Name']