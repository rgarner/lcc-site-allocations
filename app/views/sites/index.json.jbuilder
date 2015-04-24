json.array!(@sites) do |site|
  site_json(json, site)
  feature_json(json, site)
end
