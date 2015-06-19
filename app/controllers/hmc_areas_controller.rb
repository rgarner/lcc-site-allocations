class HmcAreasController < ApplicationController
  def index
    respond_to do |format|
      format.geojson do
        @hmc_areas = HmcArea.include_geojson.all
        render geojson: @hmc_areas
      end
    end
  end
end
