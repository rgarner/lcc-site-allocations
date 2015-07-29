class AllocationsController < ApplicationController
  has_scope :by_policy
  has_scope :containing_text
  has_scope :by_green_status

  def index
    if current_scopes[:by_green_status] && current_scopes[:by_policy] != 'HG2'
      current_scopes.delete(:by_green_status)
    end
    @allocations = apply_scopes(Allocation).all
  end

  def show
  end
end
