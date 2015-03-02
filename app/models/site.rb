class Site < ActiveRecord::Base
  has_many :scores

  scope :by_green_status, ->(status) {
    pattern = status.to_s.sub('mixed', 'mix')
    where "sites.green_brown ~* '#{pattern}'"
  }

  scope :with_scores, ->(with) {
    where("#{with == '0' ? 'NOT' : ''} EXISTS (SELECT 1 FROM scores WHERE site_id = sites.id)")
  }

  def to_param
    shlaa_ref
  end

  def green_status
    case green_brown
      when /mix/i then :mixed
      when /greenfield/i then :green
      when /brownfield/i then :brown
    else
      nil
    end
  end

  def total_score
    scores.inject(0) do |total, score|
      numeric_score = score.to_i
      total += numeric_score if numeric_score
      total
    end
  end
end
