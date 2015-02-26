class SitesController < ApplicationController
  def index
    @sites = Site.all
  end

  def show
    @site = Site.find_by(shlaa_ref: params[:id])
  end
end
