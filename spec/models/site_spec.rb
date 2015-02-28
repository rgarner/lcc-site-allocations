require 'rails_helper'

describe Site, :type => :model do
  describe '#total_score' do
    let(:site) { Site.new }

    subject(:total_score) { site.total_score }

    context 'there are no scores for the site' do

      it 'has a score of 0' do
        expect(site.total_score).to eql(0)
      end
    end

    context 'there are scores for the site' do
      let(:scores) { [
        Score.new(score: 'x'),
        Score.new(score: '-2'),
        Score.new(score: '-1'),
        Score.new(score: '0'),
        Score.new(score: '1'),
        Score.new(score: '2'),
        Score.new(score: '0?')
      ] }
      before { site.scores = scores }

      it 'has a score of 0' do
        expect(site.total_score).to eql(0)
      end
    end
  end

  describe '#green_status' do
    let(:site) { Site.new(green_brown: str) }

    subject { site.green_status }

    context 'site is green' do
      let(:str) { 'Greenfield' }
      it { should be :green }
    end
    context 'site is brown' do
      let(:str) { 'Brownfield' }
      it { should be :brown }
    end
    context 'site is mixed' do
      let(:str) { 'Mixed' }
      it { should be :mixed }
    end
    context 'site is neither' do
      let(:str) { 'n/a' }
      it { should be_nil }
    end
    context 'site is unknown' do
      let(:str) { 'flurp' }
      it { should be_nil }
    end
  end
end
