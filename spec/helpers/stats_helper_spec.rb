require 'rails_helper'

RSpec.describe StatsHelper, :type => :helper do
  describe '#named_to_rgba' do
    context 'named color does not exist' do
      it 'raises an ArgumentError' do
        expect { helper.named_to_rgba('octarine') }.to raise_error(ArgumentError, /octarine is an imaginary color/)
      end
    end
    context 'no alpha value is given' do
      it 'translates named colors to rgba(...) with a defaulting to 1' do
        expect(helper.named_to_rgba('green')).to eq('rgba(0,128,0,1.0)')
      end
    end
    context 'an alpha value is given' do
      it 'translates named colors to rgba(...) with a set to the alpha value' do
        expect(helper.named_to_rgba('green', alpha: 0.5)).to eq('rgba(0,128,0,0.5)')
      end
    end
  end
end
