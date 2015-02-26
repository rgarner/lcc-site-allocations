class ScoreType < ActiveRecord::Base
  def to_param
    sa_objective_code
  end
end
