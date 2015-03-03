require 'rails_helper'
RSpec.describe SitesController, :type => :controller do

  # This should return the minimal set of attributes required to create a valid
  # Site. As you add validations to Site, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    { shlaa_ref: '2062' }
  }

  let(:invalid_attributes) {
    { }
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # SitesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all sites as @sites" do
      site = Site.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:sites)).to eq([site])
    end
  end

  describe "GET show" do
    context 'site exists' do
      it "assigns the requested site as @site" do
        site = Site.create! valid_attributes
        get :show, {:id => site.to_param}, valid_session
        expect(assigns(:site)).to eq(site)
      end
    end

    context 'site does not exist' do
      it '404s' do
        get :show, {:id => 123456789}, valid_session
        expect(response.code).to eql('404')
      end
    end
  end
end
