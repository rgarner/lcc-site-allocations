require 'rails_helper'

def create_area_with_json
  area = create :hmc_area
  HmcArea.include_geojson.find_by(code: area.code)
end

describe 'hmc_areas/index.geojson.jbuilder' do
  let(:hmc_area1) { create_area_with_json }
  let(:hmc_area2) { create_area_with_json }

  before do
    assign(:hmc_areas, [hmc_area1, hmc_area2])
    render
  end

  subject(:json) { JSON.parse(rendered) }

  it 'has all the areas' do
    expect(json['features'].size).to eql(2)
  end

  describe 'the first feature' do
    subject(:feature) { json['features'][0] }

    example { expect(feature['type']).to eql('Feature') }

    describe 'the properties' do
      subject(:properties) { feature['properties'] }

      example { expect(properties['name']).to eql(hmc_area1.name) }
      example { expect(properties['code']).to eql(hmc_area1.code) }
    end

    describe 'the geometry' do
      subject(:geometry) { feature['geometry'] }

      example { expect(geometry['type']).to eql('Polygon') }
      example { expect(geometry['coordinates'][0].size).to eql(12) }
    end

  end
end
