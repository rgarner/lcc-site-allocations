require 'site_allocations/import/sites'
require 'site_allocations/import/score_types'
require 'site_allocations/import/scores'
require 'site_allocations/import/boundaries'
require 'site_allocations/import/hmc_areas'
require 'open-uri'

namespace :import do
  desc 'Import all from web'
  task :from_web => :environment do
    module SiteAllocations::Import
      WEB_BASE = 'https://raw.githubusercontent.com/rgarner/lcc-site-allocations-data/master/data/output'

      [Sites, ScoreTypes, Scores, Boundaries, HmcAreas].each do |klass|
        underscored = klass.name.demodulize.underscore # => score_types

        csv_base = "#{underscored}.csv"
        url      = "#{WEB_BASE}/#{csv_base}"
        filename = "/tmp/#{csv_base}"

        File.open(filename, "wb") do |saved_file|
          puts "Downloading #{url}"
          open(url, "rb") do |read_file|
            saved_file.write(read_file.read)
          end
        end

        klass.new(filename).run!
      end
    end
  end
end
