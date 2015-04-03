class StatsController < ApplicationController
  def summary
    @green_brown_summary = Site.green_brown_summary
  end

  def distribution
    @distribution = Site.distribution
  end
end
