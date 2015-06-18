require 'rails_helper'
require 'site_allocations/import/hmc_areas'

describe SiteAllocations::Import::HmcAreas do
  context 'no file' do
    it 'fails' do
      expect { SiteAllocations::Import::HmcAreas.new('not there.csv').run! }.to raise_error(
                                                                                    Errno::ENOENT
                                                                                  )
    end
  end

  context 'everything is fine, and everyone is happy' do
    let(:filename) { 'spec/fixtures/import/hmc_areas.csv' }

    before do
      SiteAllocations::Import::HmcAreas.new(filename).run!
    end

    it 'added some areas' do
      expect(HmcArea.count).to eql(2)
    end

    describe 'the first' do
      subject(:area) { HmcArea.find_by!(code: 1) }

      specify { expect(area.code).to eql(1) }
      specify { expect(area.name).to eql('Somewhere') }
      specify { expect(area.boundary).not_to be_nil }
    end
  end
end
