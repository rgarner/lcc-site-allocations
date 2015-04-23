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
    let!(:site)        { Site.create!(shlaa_ref: 'exist1') }
    let!(:score_type)  { ScoreType.create(sa_objective_code: 'SA01') }
    let!(:score_type2) { ScoreType.create(sa_objective_code: 'SA02') }

    let(:filename) { 'spec/fixtures/import/scores.csv' }

    let(:logger)   { instance_spy Logger }

    before do
      SiteAllocations::Import::Scores.new(filename, logger).run!
    end

    it 'imported all scores for which there were score types' do
      expect(::Score.all.count).to eql(2)
    end

    it 'pre-totalled the results for the Site' do
      expect(site.reload.total_score).to eql(1)
    end

    describe 'the first' do
      subject(:score) { Score.find_by!(shlaa_ref: 'exist1', score_type: score_type) }

      example { expect(score.score).to eql('0') }
      example { expect(score.site).to eql(site) }
      example { expect(score.score_type).to eql(score_type) }

      it 'warns about sites it could not find' do
        expect(logger).to have_received(:warn).with('no site for notexist2')
      end
    end

    describe 'a second import' do
      before do
        SiteAllocations::Import::Scores.new(filename, logger).run!
      end

      it 'does not zero the scores' do
        expect(site.reload.total_score).to eql(1)
      end
    end
  end
end
