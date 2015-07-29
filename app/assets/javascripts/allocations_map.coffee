#
# Manage the leaflet map and its geoJSON features.
# Knows how to:
#   * Style sites
#   * Style markers
#   * Style popups
#
class @AllocationsMap extends @FeatureMap
  bindPopup = (feature, layer) ->
    allocation = feature.properties # for readability in the template
    layer.bindPopup("""
      <h3>
        <a href="/allocations/#{allocation.plan_ref}">#{allocation.plan_ref} #{allocation.address}</a>
        <span class="score label #{ if allocation.score? then Site.getClassName(allocation.score) else ''}">
        #{if allocation.score? then allocation.score else ''}
        </span>
      </h3>
    """, { minWidth: 200, planRef: allocation.plan_ref} )

  createColorMarker = (feature, latlng) ->
    iconName = Site.getClassName(feature.properties.score)
    L.marker(
        latlng, {
          icon: new ColorIcon({
            iconUrl:       "/assets/#{iconName}.png",
            iconRetinaUrl: "/assets/#{iconName}2x.png"
        })
    })

  getBoundaryStyle = (feature) ->
    {
      style: null,
      className: "boundary #{Site.getClassName(feature.properties.score)}"
    }

  draw: ->
    super

    @layersByPlanRef = {}

    @featureLayer = L.geoJson(
      @data_feature,
      onEachFeature: (feature, layer) =>
        @layersByPlanRef[feature.properties.plan_ref] = layer
        bindPopup(feature, layer)
      pointToLayer:  createColorMarker,
      style:         getBoundaryStyle
    )

    @markers.addLayer(@featureLayer)
    @markers.addTo(@map);

    if @options.fitMapToBounds
      @fitBounds()
