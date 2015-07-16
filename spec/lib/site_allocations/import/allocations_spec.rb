require 'rails_helper'
require 'site_allocations/import/allocations'

describe SiteAllocations::Import::Allocations do
  context 'no file' do
    it 'fails' do
      expect { SiteAllocations::Import::Allocations.new('not there.csv').run! }.to raise_error(
        Errno::ENOENT
      )
    end
  end

  context 'everything is fine, and everyone is happy' do
    let(:filename) { 'spec/fixtures/import/allocations.csv' }

    let!(:site_734)   { create :site, shlaa_ref: '734' }
    let!(:site_1180A) { create :site, shlaa_ref: '1180A' }
    let!(:site_1311)  { create :site, shlaa_ref: '1311' }

    before do
      SiteAllocations::Import::Allocations.new(filename).run!
    end

    it 'imported two allocations' do
      expect(::Allocation.all.count).to eql(2)
    end

    describe 'the first' do
      subject(:allocation) { Allocation.find_by(plan_ref: 'HG1-1') }

      example { expect(allocation.plan_ref).to eql('HG1-1') }
      example { expect(allocation.address).to include('Bradford Road') }
      example { expect(allocation.area_ha).to be_nil }
      example { expect(allocation.capacity).to eql(349) }
      example { expect(allocation.completed_post_2012).to eql(335) }
      example { expect(allocation.not_started).to eql(0) }
      example { expect(allocation.under_construction).to eql(14) }
      example { expect(allocation.green_brown).to be_nil }
      example { expect(allocation.status).to eql('Draft') }

      example { expect(allocation.sites.to_a).to match_array([site_734]) }
      example { expect(site_734.reload.allocation).to eql(allocation) }
    end

    describe 'the second' do
      subject(:allocation) { Allocation.find_by(plan_ref: 'HG2-5') }

      example { expect(allocation.address).to include('Coach Road') }
      example { expect(allocation.area_ha).to eql(5.3) }

      example { expect(allocation.sites.to_a).to match_array([site_1180A, site_1311]) }
      example { expect(site_1311.reload.allocation).to eql(allocation) }
      example { expect(site_1180A.reload.allocation).to eql(allocation) }
    end
  end
end
