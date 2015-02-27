require 'rails_helper'

describe ScoreTypePresenter do
  let(:score_type) { double(ScoreType, sa_objective_code: 'SA01', description: 'test') }

  subject(:presenter) { ScoreTypePresenter.new(score_type) }

  it 'adds a display_name consisting of a ScoreType\'s sa code and description' do
    expect(presenter.display_name).to eql('SA01: test')
  end
end
