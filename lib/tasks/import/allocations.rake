require 'site_allocations/import/allocations'

namespace :import do
  desc 'Import allocations'
  task :allocations => :environment do
    DEFAULT_ALLOCATIONS_CSV = '../lcc-site-allocations-data/data/output/allocations.csv'
    SiteAllocations::Import::Allocations.new(DEFAULT_ALLOCATIONS_CSV).run!
  end
end
