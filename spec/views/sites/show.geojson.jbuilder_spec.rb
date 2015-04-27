require 'rails_helper'

describe 'sites/show.geojson.jbuilder' do
  before do
    assign(:site, site)
    render
  end

  subject(:json) { JSON.parse(rendered) }

  context 'site has a boundary and a centroid' do
    let!(:site) do
      create(:site,
             shlaa_ref: '2062',
             address: 'somewhere',
             boundary: 'POLYGON((-1.47486759802822 53.8426310787134,-1.47405228707635 53.8434637700614,-1.47035086877967 53.8433086917616,-1.47021270788897 53.8433910009922,-1.46758423736764 53.8432845766634,-1.4696329352046 53.8407270784017,-1.47323823376588 53.840839869631,-1.47336705217763 53.8412007147184,-1.47395562835178 53.8421119831296,-1.47399856782236 53.8424949717742,-1.47440631312983 53.8425993840685,-1.47486759802822 53.8426310787134))',
             centroid: 'POINT(-1.47486759802822 53.8426310787134)',
             total_score: -12
      )
    end

    describe 'the feature is the JSON' do
      subject(:feature) { json }

      example { expect(feature['type']).to eql('Feature') }

      describe 'the geoJSON properties are the primary API way to get info about the site' do
        subject(:properties) { feature['properties'] }

        example { expect(properties['name']).to  eql(site.address) }
        example { expect(properties['address']).to eql(site.address) }
        example { expect(properties['score']).to eql(site.total_score) }
        example { expect(properties['shlaa_ref']).to eql(site.shlaa_ref) }
        example { expect(properties['address']).to eql(site.address) }
        example { expect(properties['area_ha']).to eql(site.area_ha) }
        example { expect(properties['capacity']).to eql(site.capacity) }
        example { expect(properties['io_rag']).to eql(site.io_rag) }
        example { expect(properties['settlement_hierarchy']).to eql(site.settlement_hierarchy) }
        example { expect(properties['green_brown']).to eql(site.green_brown) }
        example { expect(properties['reason']).to eql(site.reason) }
      end

      describe 'the geometry' do
        subject(:geometry) { feature['geometry'] }

        example { expect(geometry['type']).to eql('Polygon') }
        example { expect(geometry['coordinates'][0].size).to eql(12) }
      end
    end
  end

  context 'site only has a centroid' do
    let!(:site) do
      create(:site,
             shlaa_ref: '2062',
             address: 'somewhere',
             centroid: 'POINT(-1.47486759802822 53.8426310787134)',
             total_score: -12
      )
    end

    describe 'the feature is the centroid' do
      subject(:feature) { json }

      example { expect(feature['type']).to eql('Feature') }

      describe 'the properties' do
        subject(:properties) { feature['properties'] }

        example { expect(properties['name']).to  eql(site.address) }
        example { expect(properties['score']).to eql(site.total_score) }
      end

      describe 'the geometry' do
        subject(:geometry) { feature['geometry'] }

        example { expect(geometry['type']).to eql('Point') }
        example { expect(geometry['coordinates']).to eql([-1.47486759802822, 53.8426310787134]) }
      end
    end
  end
end
