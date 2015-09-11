class Allocation < ActiveRecord::Base
  include HasTextBasedGreenStatus
  include PgSearch
  pg_search_scope :containing_text, against: { plan_ref: 'A', address: 'A' }

  has_many :sites

  scope :by_policy, -> (policy)  {
    where 'allocations.plan_ref ~ ?', [policy]
  }

  scope :by_green_status, ->(status) {
    pattern = status.to_s.sub('mixed', 'mix')
    where "allocations.green_brown ~* '#{pattern}'"
  }

  scope :include_site_geojson, -> {
    select(
      'allocations.*,'\
      'sites.shlaa_ref, sites.address, sites.total_score,'\
           'sites.area_ha, sites.capacity, sites.io_rag, sites.settlement_hierarchy,'\
           'sites.green_brown, sites.reason,'\
           'ST_AsGeoJSON(COALESCE(sites.boundary, sites.centroid)) AS geojson').
    joins('LEFT JOIN sites ON sites.allocation_id = allocations.id').includes(:sites)
  }

  def to_param
    plan_ref
  end
end
