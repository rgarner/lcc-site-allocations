class Site < ActiveRecord::Base
  has_many :scores

  scope :by_green_status, ->(status) {
    pattern = status.to_s.sub('mixed', 'mix')
    where "sites.green_brown ~* '#{pattern}'"
  }

  scope :with_scores, ->(with) {
    where("#{with == '0' ? 'NOT' : ''} EXISTS (SELECT 1 FROM scores WHERE site_id = sites.id)")
  }

  scope :green_brown_summary, -> {
    self.find_by_sql(
      <<-SQL
        SELECT
          CASE
           WHEN green_brown ~* 'mix'   THEN 'mix'
           WHEN green_brown ~* 'green' THEN 'green'
           WHEN green_brown ~* 'brown' THEN 'brown'
           ELSE NULL
          END AS coalesced_green_brown
          , COUNT(*)
          , MIN(total_score)
          , MAX(total_score)
          , ROUND(avg(total_score), 2) as average
          , ROUND(STDDEV(total_score), 2) as stddev
          FROM
            sites
          WHERE
            green_brown != '' AND green_brown != 'n/a'
          GROUP BY
            coalesced_green_brown
          ORDER BY
           average DESC;
      SQL
    )
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
end
