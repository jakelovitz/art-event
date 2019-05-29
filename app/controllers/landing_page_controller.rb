class LandingPageController < ApplicationController

  def home
    @popular_events = Popular.new.parse
  end

end
