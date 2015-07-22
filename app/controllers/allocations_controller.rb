class AllocationsController < ApplicationController
  def index
    @allocations = Allocation.all
  end

  def show
  end
end
