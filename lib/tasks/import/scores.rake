require 'site_allocations/import/scores'

namespace :import do
  desc 'Import scores'
  task :scores => :environment do
    DEFAULT_SCORES_CSV = '../lcc-site-allocations-data/data/output/scores.csv'
    SiteAllocations::Import::Scores.new(DEFAULT_SCORES_CSV).run!
  end
end
