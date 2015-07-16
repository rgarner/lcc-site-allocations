class CreateAllocations < ActiveRecord::Migration
  def change
    create_table :allocations do |t|
      t.string :plan_ref
      t.string :address
      t.string :allocation_ref
      t.integer :capacity
      t.integer :completed_post_2012
      t.integer :under_construction
      t.integer :not_started
      t.float :area_ha
      t.string :green_brown
      t.string :status, default: 'Draft'

      t.timestamps null: false
    end

    add_index :allocations, :plan_ref, unique: true

    add_column :sites, :allocation_id, :integer
    add_index :sites, :allocation_id
  end
end
