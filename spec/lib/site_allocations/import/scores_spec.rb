require 'rails_helper'
require 'site_allocations/import/scores'

describe SiteAllocations::Import::Scores do
  context 'no file' do
    it 'fails' do
      expect { SiteAllocations::Import::Scores.new('not there.csv').run! }.to raise_error(
        Errno::ENOENT
      )
    end
  end

  context 'everything is fine, and everyone is happy' do
    let(:filename) { 'spec/fixtures/import/scores.csv' }

    before do
      SiteAllocations::Import::Scores.new(filename).run!
    end

    it 'imported lots' do
      expect(::Scores.all.count).to eql(200)
    end

    describe 'the first' do
      subject(:type) { Score.find_by(sa_objective_code: 'SA1') }

      example { expect(type.description).to eql('Employment') }
      example { expect(type.assumptions).to include('Based on the location') }
      example { expect(type.scoring_descriptions).to include('Proposed Employment Use') }
    end
  end
end
