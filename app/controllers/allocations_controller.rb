class AllocationsController < ApplicationController
  has_scope :by_policy
  has_scope :containing_text

  def index
    @allocations = apply_scopes(Allocation).all
  end

  def show
  end
end
