class Site < ActiveRecord::Base
  include PgSearch
  pg_search_scope :containing_text, against: { shlaa_ref: 'A', address: 'A', reason: 'B' }

  has_many :scores

  belongs_to :allocation

  scope :by_green_status, ->(status) {
    pattern = status.to_s.sub('mixed', 'mix')
    where "sites.green_brown ~* '#{pattern}'"
  }

  scope :by_io_rag, ->(io_rag) {
    where(io_rag: io_rag)
  }

  scope :with_scores, ->(with) {
    where("#{with == '0' ? 'NOT' : ''} EXISTS (SELECT 1 FROM scores WHERE site_id = sites.id)")
  }

  # A normal SELECT scope but optimised so that PostGIS takes the strain of serializing
  # the boundary or centroid - around 5x faster than letting rgeo do it via SitesHelper#feature_json
  scope :include_geojson, -> {
    select('sites.shlaa_ref, sites.address, sites.total_score,'\
           'sites.area_ha, sites.capacity, sites.io_rag, sites.settlement_hierarchy,'\
           'sites.green_brown, sites.reason,'\
           'ST_AsGeoJSON(COALESCE(sites.boundary, sites.centroid)) AS geojson')
  }

  scope :sort_by_capacity, ->(sort_order) {
    case sort_order.try(:to_sym)
    when :asc then order('sites.capacity NULLS LAST')
    when :desc then order('sites.capacity DESC NULLS LAST')
    else unscoped
    end
  }

  scope :sort_by_area, ->(sort_order) {
    case sort_order.try(:to_sym)
    when :asc then order('sites.area_ha NULLS LAST')
    when :desc then order('sites.area_ha DESC NULLS LAST')
    else unscoped
    end
  }

  scope :sort_by_score, ->(sort_order) {
    case sort_order.try(:to_sym)
    when :asc then order('sites.total_score NULLS LAST')
    when :desc then order('sites.total_score DESC NULLS LAST')
    else unscoped
    end
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

  scope :distribution, -> {
    self.find_by_sql(
      <<-SQL
        SELECT CASE
          WHEN green_brown ~* 'mix'   THEN 'mix'
          WHEN green_brown ~* 'green' THEN 'green'
          WHEN green_brown ~* 'brown' THEN 'brown'
          ELSE green_brown
        END AS coalesced_green_brown,
        COUNT(*),
        total_score
        FROM
          sites
        WHERE
          green_brown <> ''
        GROUP BY
          coalesced_green_brown, total_score
        ORDER BY
          total_score, coalesced_green_brown;
      SQL
    )
  }

  scope :unsustainable, -> {
    where("sites.total_score < 0 AND sites.io_rag = 'G'").
    order(:total_score)
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
