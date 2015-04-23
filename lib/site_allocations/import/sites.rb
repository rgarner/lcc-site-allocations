require 'csv'

module SiteAllocations
  module Import
    class Sites < Struct.new(:filename)
      def run!
        CSV.read(filename, headers: true).each do |row|
          Site.find_or_create_by!(shlaa_ref: row['SHLAA Ref']) do |site|
            # SHLAA Ref,Address,Area ha,_something_,Capacity,I&O RAG,Settlement Hierarchy,Green/Brown,Reason
            site.address = row['Address']
            site.area_ha = row['Area ha']
            site.capacity = row['Capacity']
            site.io_rag = row['I&O RAG']
            site.settlement_hierarchy = row['Settlement Hierarchy']
            site.green_brown = row['Green/Brown']
            site.reason = row['Reason']
          end

          if row['Easting'] && row['Northing'] && row['Northing'] != 'area' # temporary workaround for 5158
            point_wkt = "POINT(#{row['Easting']} #{row['Northing']})"
            Site.connection.execute(
              <<-SQL
                UPDATE sites
                SET centroid = ST_Transform(ST_GeomFromText('#{point_wkt}', 27700), 4326)
                WHERE shlaa_ref='#{row['SHLAA Ref']}'
              SQL
            )
          end
        end
      end
    end
  end
end
