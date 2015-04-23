class AddCentroidToSites < ActiveRecord::Migration
  def change
    add_column :sites, :centroid, :st_point, srid: 4326
  end
end
