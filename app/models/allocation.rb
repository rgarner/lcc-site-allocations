class Allocation < ActiveRecord::Base
  include HasTextBasedGreenStatus

  has_many :sites

  def to_param
    plan_ref
  end
end
