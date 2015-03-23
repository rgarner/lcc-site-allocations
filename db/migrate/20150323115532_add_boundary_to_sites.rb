class AddBoundaryToSites < ActiveRecord::Migration
  def change
    add_column :sites, :boundary, :st_polygon, srid: 4326
  end
end
