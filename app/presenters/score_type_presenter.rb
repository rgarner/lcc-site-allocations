class ScoreTypePresenter < SimpleDelegator
  def model
    __getobj__
  end

  def display_name
    "#{model.sa_objective_code}: #{model.description}"
  end
end
