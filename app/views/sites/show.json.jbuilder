json.shlaa_ref            @site.shlaa_ref
json.address              @site.address
json.area_ha              @site.area_ha
json.capacity             @site.capacity
json.io_rag               @site.io_rag
json.settlement_hierarchy @site.settlement_hierarchy
json.green_brown          @site.green_brown
json.reason               @site.reason

feature_value = @site.boundary || @site.centroid

if feature_value
  feature = RGeo::GeoJSON::EntityFactory.instance.feature(
    feature_value,
    nil,
    {
      name:  @site.address,
      score: @site.total_score
    }
  )

  json.feature(RGeo::GeoJSON.encode(feature))
end
