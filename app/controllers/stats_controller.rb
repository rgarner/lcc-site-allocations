class StatsController < ApplicationController
  def index
    @green_brown_summary = Site.green_brown_summary
  end
end
