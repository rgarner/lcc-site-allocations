require 'rails_helper'
require 'site_allocations/import/score_types'

describe SiteAllocations::Import::ScoreTypes do
  context 'no file' do
    it 'fails' do
      expect { SiteAllocations::Import::ScoreTypes.new('not there.csv').run! }.to raise_error(
        Errno::ENOENT
      )
    end
  end

  context 'everything is fine, and everyone is happy' do
    let(:filename) { 'spec/fixtures/import/score_types.csv' }

    before do
      SiteAllocations::Import::ScoreTypes.new(filename).run!
    end

    it 'imported two sites' do
      expect(::ScoreType.all.count).to eql(2)
    end

    describe 'the first' do
      subject(:type) { ScoreType.find_by(sa_objective_code: 'SA1') }

      example { expect(type.description).to eql('Employment') }
      example { expect(type.assumptions).to include('Based on the location') }
      example { expect(type.scoring_descriptions).to include('Proposed Employment Use') }
    end
  end
end
