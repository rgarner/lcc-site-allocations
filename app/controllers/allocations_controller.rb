class AllocationsController < ApplicationController
  has_scope :by_policy

  def index
    @allocations = apply_scopes(Allocation).all
  end

  def show
  end
end
