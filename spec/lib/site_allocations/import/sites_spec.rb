require 'rails_helper'
require 'site_allocations/import/sites'

describe SiteAllocations::Import::Sites do
  context 'no file' do
    it 'fails' do
      expect { SiteAllocations::Import::Sites.new('not there.csv').run! }.to raise_error(
        Errno::ENOENT
      )
    end
  end

  context 'everything is fine, and everyone is happy' do
    let(:filename) { 'spec/fixtures/import/sites.csv' }

    before do
      SiteAllocations::Import::Sites.new(filename).run!
    end

    it 'imported two sites' do
      expect(::Site.all.count).to eql(2)
    end

    describe 'the first' do
      subject(:site) { Site.find_by(shlaa_ref: '34') }

      example { expect(site.shlaa_ref).to eql('34') }
      example { expect(site.address).to include('Low Hall Road') }
      example { expect(site.address).to include('LS19') }
      example { expect(site.area_ha).to eql(7.9) }
      example { expect(site.capacity).to eql(60) }
      example { expect(site.io_rag).to eql('LG') }
      example { expect(site.settlement_hierarchy).to eql('Main Urban Area Extension') }
      example { expect(site.green_brown).to eql('Brownfield') }
      example { expect(site.reason).to include('recently expired planning') }
      example { expect(site.centroid.to_s).to match /POINT \(-1\.670673.* 53\.8344028.*\)/ }
    end
  end
end
