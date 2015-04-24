require 'rails_helper'

describe 'sites/index.geojson.jbuilder' do
  before do
    assign(:sites, [boundary_site, centroid_site, no_geo_site])
    render
  end

  subject(:json) { JSON.parse(rendered) }

  context 'one has a boundary and a centroid, one has only a centroid, one has none' do
    let!(:boundary_site) do
      create(:site,
             shlaa_ref: '2062',
             address: 'somewhere1',
             boundary: 'POLYGON((-1.47486759802822 53.8426310787134,-1.47405228707635 53.8434637700614,-1.47035086877967 53.8433086917616,-1.47021270788897 53.8433910009922,-1.46758423736764 53.8432845766634,-1.4696329352046 53.8407270784017,-1.47323823376588 53.840839869631,-1.47336705217763 53.8412007147184,-1.47395562835178 53.8421119831296,-1.47399856782236 53.8424949717742,-1.47440631312983 53.8425993840685,-1.47486759802822 53.8426310787134))',
             centroid: 'POINT(-1.47486759802822 53.8426310787134)',
             total_score: -12
      )
    end
    let!(:centroid_site) do
      create(:site,
             shlaa_ref: '797',
             address: 'somewhere2',
             centroid: 'POINT(-1.47486759802822 53.8426310787134)',
             total_score: +11
      )
    end
    let!(:no_geo_site) do
      create(:site,
             shlaa_ref: '12',
             address: 'no-geo-site',
             total_score: +15
      )
    end

    it 'has all the sites' do
      expect(json['features'].size).to eql(3)
    end

    describe 'the boundary feature' do
      subject(:feature) { json['features'][0] }

      example { expect(feature['type']).to eql('Feature') }

      describe 'the properties' do
        subject(:properties) { feature['properties'] }

        example { expect(properties['name']).to  eql(boundary_site.address) }
        example { expect(properties['score']).to eql(boundary_site.total_score) }
      end

      describe 'the geometry' do
        subject(:geometry) { feature['geometry'] }

        example { expect(geometry['type']).to eql('Polygon') }
        example { expect(geometry['coordinates'][0].size).to eql(12) }
      end
    end

    describe 'the centroid feature' do
      subject(:feature) { json['features'][1] }

      example { expect(feature['type']).to eql('Feature') }

      describe 'the properties' do
        subject(:properties) { feature['properties'] }

        example { expect(properties['name']).to  eql(centroid_site.address) }
        example { expect(properties['score']).to eql(centroid_site.total_score) }
      end

      describe 'the geometry' do
        subject(:geometry) { feature['geometry'] }

        example { expect(geometry['type']).to eql('Point') }
        example { expect(geometry['coordinates'].size).to eql(2) }
      end
    end

    describe 'the no-geo feature' do
      subject(:feature) { json['features'][2] }

      example { expect(feature['type']).to eql('Feature') }

      describe 'the properties' do
        subject(:properties) { feature['properties'] }

        example { expect(properties['name']).to  eql(no_geo_site.address) }
        example { expect(properties['score']).to eql(no_geo_site.total_score) }
      end

      it 'has no geometry' do
        expect(json['features'].last.fetch('geometry')).to be_nil
      end
    end
  end
end
