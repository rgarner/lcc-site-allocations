class Score < ActiveRecord::Base
  belongs_to :site
  belongs_to :score_type

  def to_i
    case score
    when '0?' then 0
    when 'x' then nil
    else
      score.to_i
    end
  end

  def uncertain?
    score[-1] == '?'
  end

  VERY_NEGATIVE = -58..-11
  NEGATIVE      = -10..-1
  NEUTRAL       = 0
  POSITIVE      = 1..10
  VERY_POSITIVE = 11..58
end
