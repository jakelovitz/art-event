class Event < ApplicationRecord

  def self.locations

    event_locations = {
    "Queens": 'queens.en.xml',
    "Harlem/Bronx": 'harlem_bronx.en.xml',
    "Williamsburg": 'williamsburg.en.xml',
    "Dumbo/Other Brooklyn": 'dumbo_brooklyn.en.xml',
    "Upper East Side": 'upper_east_side.en.xml',
    "Midtown": 'midtown.en.xml',
    "Flatiron/Gramercy": 'flatiron_gramercy.en.xml',
    "East Chelsea": 'chelsea_east.en.xml',
    "Chelsea 28-33": 'chelsea_28_above.en.xml',
    "Chelsea 27": 'chelsea_27.en.xml',
    "Chelsea 26": 'chelsea_26.en.xml',
    "Chelsea 25": 'chelsea_25.en.xml',
    "Chelsea 24": 'chelsea_24.en.xml',
    "Chelsea 23": 'chelsea_23.en.xml',
    "Chelsea 22": 'chelsea_22.en.xml',
    "Chelsea 21": 'chelsea_21.en.xml',
    "Chelsea 20": 'chelsea_20.en.xml',
    "Chelsea 14-19": 'chelsea_19_below.en.xml',
    "Villages": 'villages.en.xml',
    "Soho": 'soho.en.xml',
    "Lower East Side": 'lower_east_side.en.xml',
    "Lower Manhattan": 'lower_manhattan.en.xml'
  }

  event_locations
  end
    
  def self.get_nyartbeat_by_location(params)
    @location = RestClient.get("http://www.nyartbeat.com/list/event_area_#{params[:location]}") #alter URL by input
			Crack::XML.parse(@location)
  end

end
