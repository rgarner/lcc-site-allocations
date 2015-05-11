json.type 'FeatureCollection'
json.features do
  json.array! @sites.map { |site| feature_json(site) }
end
