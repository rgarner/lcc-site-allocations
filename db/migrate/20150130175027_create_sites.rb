class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.string :shlaa_ref
      t.string :address
      t.float :area_ha
      t.integer :capacity
      t.string :io_rag
      t.string :settlement_hierarchy
      t.string :green_brown
      t.string :reason
    end

    add_index :sites, :shlaa_ref, unique: true
  end
end
