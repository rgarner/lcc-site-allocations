require 'site_allocations/import/hmc_areas'

namespace :import do
  desc 'Import hmc_areas'
  task :hmc_areas => :environment do
    DEFAULT_HMC_AREAS_CSV = '../lcc-site-allocations-data/data/output/hmc_areas.csv'
    SiteAllocations::Import::HmcAreas.new(DEFAULT_HMC_AREAS_CSV).run!
  end
end
