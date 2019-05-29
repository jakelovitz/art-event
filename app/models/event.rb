#: Schema Information
#
# Table name: events
#
#  id                :integer          not null, primary key
#  event_name        :string
#  venue_name        :string
#  address           :string
#  phone             :string
#  directions        :string
#  neighborhood      :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  opening_hour      :string
#  closing_hour      :string
#  event_description :text
#  img_url           :string
#  admission         :string
#  date_start        :date
#  date_end          :date
#  api_id            :string
#  venue_type        :string
#

class Event < ApplicationRecord
  has_many :user_events
  has_many :users, through: :user_events

  validates :event_name, :venue_name, :address, :neighborhood, presence: true


  def self.locations
    {
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
  end
    
  def self.get_nyartbeat_by_location(params)
    location = RestClient.get("http://www.nyartbeat.com/list/event_area_#{params[:location]}")
    create_from_api_call(Crack::XML.parse(location)['Events']['Event'])
  end

  private

  def self.create_from_api_call(events_array)
    events_array.each do |event|
      next if find_by(api_id: event['id'])
      if event['Price'] == "Free" ? value = true : value = false
      end
        create(
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
          free: value 
        )

    end
  end
end
