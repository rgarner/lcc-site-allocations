require_relative '../../app/presenters/score_type_presenter'

class ScoreTypesController < ApplicationController
  def show
    @score_type = ScoreTypePresenter.new(
      ScoreType.find_by(sa_objective_code: params[:id])
    )
  end
end
