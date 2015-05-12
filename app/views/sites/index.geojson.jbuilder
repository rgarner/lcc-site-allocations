json.type 'FeatureCollection'
json.features @sites do |site|
  json.type 'Feature'
  json.geometry raw_json_class.new(site.geojson)
  json.properties name: site.address,
                  score: site.total_score,
                  shlaa_ref: site.shlaa_ref,
                  address: site.address,
                  area_ha: site.area_ha,
                  capacity: site.capacity,
                  io_rag: site.io_rag,
                  settlement_hierarchy: site.settlement_hierarchy,
                  green_brown: site.green_brown,
                  reason: site.reason
end
