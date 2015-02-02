require 'site_allocations/import/sites'

namespace :import do
  desc 'Import sites'
  task :sites => :environment do
    DEFAULT_SITES_CSV = '../lcc-site-allocations-data/data/output/sites.csv'
    SiteAllocations::Import::Sites.new(DEFAULT_SITES_CSV).run!
  end
end
