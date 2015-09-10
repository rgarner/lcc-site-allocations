json.type 'FeatureCollection'
json.site_count @allocation.sites.length
json.features @allocation.sites do |site|
  json.merge! feature_json(site, plan_ref: @allocation.plan_ref)
end
