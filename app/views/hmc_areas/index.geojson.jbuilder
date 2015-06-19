json.type 'FeatureCollection'
json.features @hmc_areas do |area|
  json.type 'Feature'
  json.geometry raw_json_class.new(area.geojson)
  json.properties code: area.code,
                  name: area.name
end
