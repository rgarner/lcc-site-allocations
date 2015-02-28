require_relative 'presenter_base'

class ScorePresenter < PresenterBase
  def css_class
    "score v#{model.score.to_i}"
  end
end
