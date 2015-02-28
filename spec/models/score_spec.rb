require 'rails_helper'

describe Score, :type => :model do
  describe '#to_i, #uncertain?' do
    let(:score) { Score.new(score: score_str) }

    subject { score.to_i }

    context 'is -2' do
      let(:score_str) { '-2' }
      it { should eql(-2) }
    end
    context 'is -1' do
      let(:score_str) { '-1' }
      it { should eql(-1) }
      it 'is not uncertain' do
        expect(score.uncertain?).to eql(false)
      end
    end
    context 'is x' do
      let(:score_str) { 'x' }
      it { should be_nil }
      it 'is not uncertain' do
        expect(score.uncertain?).to eql(false)
      end
    end
    context 'is 0?' do
      let(:score_str) { '0?' }
      it { should eql(0) }
      it 'is uncertain' do
        expect(score.uncertain?).to eql(true)
      end
    end
    context 'is 0' do
      let(:score_str) { '0' }
      it { should eql(0) }
    end
    context 'is 1' do
      let(:score_str) { '1' }
      it { should eql(1) }
    end
    context 'is 2' do
      let(:score_str) { '2' }
      it { should eql(2) }
    end
  end
end
