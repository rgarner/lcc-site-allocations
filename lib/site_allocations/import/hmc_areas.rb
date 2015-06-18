require 'csv'

module SiteAllocations
  module Import
    class HmcAreas < Struct.new(:filename)
      def run!
        CSV.read(filename, headers: true).each do |row|
          HmcArea.where(code: row['Code']).first_or_create! do |area|
            area.boundary = row['WKT']
            area.name =     row['Name']
          end
        end
      end
    end
  end
end
