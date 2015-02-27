require_relative 'presenter_base'

class ScorePresenter < PresenterBase
  def css_class
    score_str = model.score == '0?' ? '0' : model.score
    "score v#{score_str}"
  end
end
