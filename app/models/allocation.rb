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

  def to_param
    plan_ref
  end
end
