require 'csv'

module SiteAllocations
  module Import
    class Scores
      attr_reader :filename, :logger
      def initialize(filename, logger = Logger.new(STDERR))
        @filename = filename
        @logger = logger
      end

      def sa_key_values(row)
        row.to_a.select { |key, _| key =~ /^SA[0-9]{1,2}[a-d]?/}
      end

      def run!
        CSV.read(filename, headers: true).each do |row|
          shlaa_ref = row['Site Ref']

          site = Site.find_by(shlaa_ref: shlaa_ref)
          if site.nil?
            logger.warn "no site for #{shlaa_ref}"
            next
          end

          total = 0
          sa_key_values(row).each do |sa_code, value|
            score_type = ScoreType.find_by(sa_objective_code: sa_code)

            if score_type.nil?
              logger.warn "no score type with sa_objective_code #{sa_code}"
              next
            end

            Score.find_or_create_by!(score_type: score_type, shlaa_ref: shlaa_ref) do |score|
              score.score_type = score_type
              score.site = site
              score.score = value

              numeric_value  = score.to_i
              total += numeric_value unless numeric_value.nil?
            end
          end

          site.update_attribute(:total_score, total)
        end
      end
    end
  end
end
