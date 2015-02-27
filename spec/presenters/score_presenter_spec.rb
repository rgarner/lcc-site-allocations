require 'rails_helper'

describe ScorePresenter do
  subject(:presenter) { ScorePresenter.new(score) }

  context 'score is uncertain' do
    let(:score) { double(Score, score: '0?') }

    it 'behaves the same as 0' do
      expect(presenter.css_class).to eql('score v0')
    end
  end

  context 'score is x' do
    let(:score) { double(Score, score: 'x') }

    it 'behaves the same as 0' do
      expect(presenter.css_class).to eql('score vx')
    end
  end

  context 'score is negative' do
    let(:score) { double(Score, score: '-1') }

    it 'behaves the same as 0' do
      expect(presenter.css_class).to eql('score v-1')
    end
  end

end
