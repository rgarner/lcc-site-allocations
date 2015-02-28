class Site < ActiveRecord::Base
  has_many :scores

  def to_param
    shlaa_ref
  end

  def total_score
    scores.inject(0) do |total, score|
      numeric_score = score.to_i
      total += numeric_score if numeric_score
      total
    end
  end
end
