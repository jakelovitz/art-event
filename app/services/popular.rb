class Popular < ApplicationService

  def new; end

  def parse_and_create
    popular_events = RestClient.get('http://www.nyartbeat.com/list/event_mostpopular.en.xml')
    create_events(Crack::XML.parse(popular_events)['Events']['Event'])
  end

  private
  def create_events(events_array)
    events_array.each do |event|
      next if Event.find_by(api_id: event['id'])
      if event['Price'] == "Free" ? value = true : value = false
      end
      Event.create(
        event_name: event['Name'],
        venue_name: event['Venue']['Name'],
        address: event['Venue']['Address'],
        phone: event['Venue']['Phone'],
        directions: event['Venue']['Access'],
        neighborhood: event['Venue']['Area'],
        opening_hour: event['Venue']['OpeningHour'],
        closing_hour: event['Venue']['ClosingHour'],
        event_description: event['Description'],
        img_url: event['Image'].last['src'].chomp('-170'),
        admission: event['Price'],
        date_start: event['DateStart'],
        date_end: event['DateEnd'],
        api_id: event['id'],
        venue_type: event['Venue']['Type'],
        free: value)
    end
  end

end