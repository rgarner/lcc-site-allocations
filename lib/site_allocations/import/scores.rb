require 'csv'

module SiteAllocations
  module Import
    class Scores < Struct.new(:filename)
      def run!
        CSV.read(filename, headers: true).each do |row|
          Score.find_or_create_by!(sa_objective_code: row['SA Objective Code']) do |score_type|
            # HMCA,Site Ref,SA01,SA02,SA03,SA04,SA05,SA06,SA07,SA08,SA09,SA10,SA11,SA12,SA13,SA14,SA15,SA16,SA17,SA18a,SA18b,SA18c,SA19,SA20,SA21,SA22a,SA22b,SA22c,SA22d,SustApprComment
            # 1,12,0,1,1,1,0,0,1,1,0,1,-2,0,1,1,0,1,0,0,0,0,-2,0,0,0,0,0,1,""
            # 1,180,0,0,1,1,0,0,1,1,0,0,1,0,1,2,1,1,0,1,0,0,0,0,0,0,0,0,0,"SA1&2 & 7 & 8 & 16 negative if in use, neutral if not"

            score_type.description = row['SA Objective Description']
            score_type.assumptions = row['Assumptions Used']
            score_type.scoring_descriptions = row['Scoring']
          end
        end
      end
    end
  end
end
