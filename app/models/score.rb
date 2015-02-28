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
end
