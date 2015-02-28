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
end
