require 'csv'

module SiteAllocations
  module Import
    class Allocations < Struct.new(:filename)
      def run!
        CSV.read(filename, headers: true).each do |row|
          Allocation.find_or_create_by!(plan_ref: row['Allocation Ref']) do |allocation|
            # Allocation Ref,SHLAA Refs,Address,Capacity,Completed post-2012, Under construction,Not started,Area HA,Green/Brown,Status
            allocation.address = row['Address']
            allocation.capacity = row['Capacity']
            allocation.completed_post_2012 = row['Completed post-2012']
            allocation.under_construction = row[' Under construction']
            allocation.not_started = row['Not started']
            allocation.area_ha = row['Area HA']
            allocation.green_brown = row['Green/Brown']
            allocation.status = row['Status']

            row['SHLAA Refs'].split('_').each do |shlaa_ref|
              allocation.sites << Site.find_by!(shlaa_ref: shlaa_ref)
              allocation.save!
            end
          end
        end
      end
    end
  end
end
