require 'site_allocations/import/score_types'

namespace :import do
  desc 'Import score_types'
  task :score_types => :environment do
    DEFAULT_SCORE_TYPES_CSV = '../lcc-site-allocations-data/data/output/score_types.csv'
    SiteAllocations::Import::ScoreTypes.new(DEFAULT_SCORE_TYPES_CSV).run!
  end
end
