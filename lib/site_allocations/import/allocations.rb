require 'csv'

module SiteAllocations
  module Import
    class Allocations < Struct.new(:filename)

      def run!
        Allocation.transaction do
          CSV.read(filename, headers: true).each do |row|
            Allocation.where(plan_ref: row['Allocation Ref']).first_or_create!.tap do |allocation|
              allocation.address             = row['Address']
              allocation.capacity            = row['Capacity']
              allocation.completed_post_2012 = row['Completed post-2012']
              allocation.under_construction  = row['Under construction']
              allocation.not_started         = row['Not started']
              allocation.area_ha             = row['Area HA']
              allocation.green_brown         = row['Green/Brown']
              allocation.status              = row['Status']

              row['SHLAA Refs'].split('_').each do |shlaa_ref|
                site = Site.find_by(shlaa_ref: shlaa_ref)
                if site
                  allocation.sites << site
                  allocation.save!
                else
                  $stderr.puts "No site found for shlaa_ref: #{shlaa_ref}"
                end
              end

            end
          end
        end
      end

    end
  end
end
