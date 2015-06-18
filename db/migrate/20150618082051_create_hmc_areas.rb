class CreateHmcAreas < ActiveRecord::Migration
  def change
    create_table :hmc_areas do |t|
      t.string :name
      t.integer :code
      t.st_polygon :boundary, srid: 4326

      t.timestamps null: false
    end

    add_index :hmc_areas, :code
  end
end
