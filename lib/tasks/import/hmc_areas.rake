require 'site_allocations/import/boundaries'

namespace :import do
  desc 'Import sites'
  task :boundaries => :environment do
    DEFAULT_BOUNDARIES_CSV = '../lcc-site-allocations-data/data/output/boundaries.csv'
    SiteAllocations::Import::Boundaries.new(DEFAULT_BOUNDARIES_CSV).run!
  end
end
