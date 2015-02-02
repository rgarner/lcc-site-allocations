class Score < ActiveRecord::Base
  belongs_to :site
  belongs_to :score_type
end
