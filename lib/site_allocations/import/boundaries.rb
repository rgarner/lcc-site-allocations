require 'csv'

module SiteAllocations
  module Import
    class Boundaries < Struct.new(:filename)
      def run!
        CSV.read(filename, headers: true).each do |row|
          site = Site.find_by(shlaa_ref: row['SHLAA Ref'])

          site.update_attribute(:boundary, row['Boundary']) if site
        end
      end
    end
  end
end
