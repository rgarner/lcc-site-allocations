class SitesController < ApplicationController
  has_scope :by_green_status
  has_scope :with_scores
  has_scope :sort_by_capacity
  has_scope :sort_by_area
  has_scope :sort_by_score
  has_scope :containing_text

  def index
    @sites  = apply_scopes(Site).all
  end

  def show
    @site = Site.find_by(shlaa_ref: params[:id]) or
      render status: 404, text: "Site #{params[:id]} not found"
  end
end
