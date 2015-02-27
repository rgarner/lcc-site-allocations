require_relative 'presenter_base'

class ScoreTypePresenter < PresenterBase
  def display_name
    "#{model.sa_objective_code}: #{model.description}"
  end
end
