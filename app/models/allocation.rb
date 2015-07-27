class Allocation < ActiveRecord::Base
  include HasTextBasedGreenStatus

  has_many :sites

  scope :by_policy, -> (policy)  {
    where 'allocations.plan_ref ~ ?', [policy]
  }

  def to_param
    plan_ref
  end
end
