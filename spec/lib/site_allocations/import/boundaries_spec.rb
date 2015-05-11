require 'rails_helper'
require 'site_allocations/import/boundaries'

describe SiteAllocations::Import::Boundaries do
  context 'no file' do
    it 'fails' do
      expect { SiteAllocations::Import::Boundaries.new('not there.csv').run! }.to raise_error(
        Errno::ENOENT
      )
    end
  end

  context 'everything is fine, and everyone is happy' do
    let!(:site_with_no_boundary)     { create :site, shlaa_ref: '4000' }
    let!(:site_not_in_boundary_file) { create :site, shlaa_ref: '99999FAB' }
    let!(:site_with_boundary)        { create :site, :with_boundary, shlaa_ref: '4002' }

    let(:filename) { 'spec/fixtures/import/boundaries.csv' }

    before do
      SiteAllocations::Import::Boundaries.new(filename).run!
    end

    it 'updated the site with no boundary' do
      expect(site_with_no_boundary.reload.boundary.as_text).to start_with('POLYGON ((-1.612835397234876 53.85542527830647,')
    end

    it 'updated the site with the boundary' do
      expect(site_with_boundary.reload.boundary.as_text).to start_with('POLYGON ((-1.570031139378183 53.77146947944599,')
    end

    it 'left the site not in the boundary file alone' do
      expect(site_not_in_boundary_file.reload.boundary).to be_nil
    end
  end
end
