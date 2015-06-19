require 'rails_helper'
RSpec.describe HmcAreasController, :type => :controller do
  describe 'GET index' do
    let!(:hmc_area) { create :hmc_area }

    context 'format is geojson' do
      it 'assigns all areas as @hmc_areas' do
        get :index, format: :geojson
        expect(assigns(:hmc_areas)).to eq([hmc_area])
      end
    end

    context 'format is html' do
      it 'is unacceptable' do
        expect { get :index, format: :html }.to raise_error(ActionController::UnknownFormat)
      end
    end
  end
end
