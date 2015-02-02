json.array!(@sites) do |site|
  json.extract! site, :id, :shlaa_ref, :address, :area_ha, :capacity, :io_rag, :settlement_hierarchy, :green_brown, :reason
  json.url site_url(site, format: :json)
end
