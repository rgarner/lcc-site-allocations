json.type 'FeatureCollection'
json.features @allocations do |allocation|
  json.type 'Feature'
  json.geometry raw_json_class.new(allocation.geojson)
  json.properties name: allocation.address,
                  plan_ref: allocation.plan_ref,
                  shlaa_ref: allocation.shlaa_ref,
                  address: allocation.address,
                  score: allocation.total_score,
                  area_ha: allocation.area_ha,
                  capacity: allocation.capacity,
                  io_rag: allocation.io_rag,
                  green_brown: allocation.green_brown
end
