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
			location = Event.get_nyartbeat_by_location(params)
        byebug
		end
		
		def create
		end

    def show
    end

    private

    # def event_params
    # 	params.require(:event).permit(:)
    # end

		# def query_api_with_location(params)
		# 	location = RestClient.get("http://www.nyartbeat.com/list/event_area_#{URI.encode(params)}") #alter URL by input
		# 	Crack::XML.parse(location)
		# end

end
