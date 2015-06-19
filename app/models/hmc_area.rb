class HmcArea < ActiveRecord::Base
  # A normal SELECT scope but optimised so that PostGIS takes the strain of serializing
  # the boundary
  scope :include_geojson, -> {
    select('hmc_areas.*, ST_AsGeoJSON(hmc_areas.boundary) AS geojson')
  }
end
