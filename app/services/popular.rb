class Popular < ApplicationService

  def new; end

  def parse
    popular_events = RestClient.get('http://www.nyartbeat.com/list/event_mostpopular.en.xml')
    Crack::XML.parse(popular_events)['Events']['Event']
  end
end