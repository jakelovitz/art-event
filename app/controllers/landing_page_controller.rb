class LandingPageController < ApplicationController

  def home
    @popular_events = Popular.new.parse_and_create
  end

end