require 'csv'

module SiteAllocations
  module Import
    class ScoreTypes < Struct.new(:filename)
      def run!
        CSV.read(filename, headers: true).each do |row|
          ScoreType.find_or_create_by!(sa_objective_code: row['SA Objective Code']) do |score_type|
            # SA Objective Code, SA Objective Description,Assumptions Used,Scoring
            # SA1,Employment,Based on the location and existing use of the site.,Proposed Employment Use  +   Proposed use will create new       employment O  Existing employment use on site  Proposed Retail Use  +   Proposed use will create new       employment O  Existing employment use on site  Proposed Housing Use  O   All sites except existing        employment use on site -     Existing employment use  - -   If single employment site in a          smaller settlement.

            score_type.description = row['SA Objective Description']
            score_type.assumptions = row['Assumptions Used']
            score_type.scoring_descriptions = row['Scoring']
          end
        end
      end
    end
  end
end
