class SiteAggregatePrecomputedColumns < ActiveRecord::Migration
  def change
    add_column :sites, :total_score, :integer
    add_column :sites, :ranking,     :integer
  end
end
