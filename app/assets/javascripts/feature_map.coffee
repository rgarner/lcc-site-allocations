#
# Manage the leaflet map and its geoJSON features.
# Knows how to:
#   * Set up the leaflet.js map
#   * Style sites
#   * Style markers
#   * Style popups
#   * Fit to displayed features if requested
#
class @FeatureMap
  OVER_LEEDS      = [53.801277, -1.548567]
  DEFAULT_OPTIONS = {
    fitMapToBounds: true
  }

  constructor: (@data_feature, @options = DEFAULT_OPTIONS) ->
    @draw()

  createClusterIcon = (cluster) ->
    children = cluster.getChildCount()
    new L.DivIcon(
      {
        className: "leaflet-div-icon cluster",
        html: """
          <div class="cluster-inner"><div class="cluster-count">#{children}</div></div>
        """
      }
    )

  getMap: -> @map

  fitBounds: (e) =>
    options = if @data_feature.type == 'Feature' and @data_feature.geometry.type == 'Point' then { maxZoom: 15 } else {}

    # Cope with race condition causing map freeze. Decorous 50ms grace given
    setTimeout ( =>
      markerBounds = @markers.getBounds()
      @map.fitBounds(markerBounds, options) if markerBounds? and markerBounds.isValid()
    ), 50

  draw: ->
    @map = L.map('map', {
      center: OVER_LEEDS,
      zoom: 12,
      scrollWheelZoom: false
    })

    osmLayer = L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
      attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
    }).addTo(@map)
    bingLayer = L.bingLayer(
      atob('QWxQRWo2a2oxT3NqeGswRTNVNmREVVMySHBMamtnQS1TRExYWGllTEpJXzdKd1VuNUNDY1F3TWRFaENUUFdycg=='))

    @markers = new L.MarkerClusterGroup({
      disableClusteringAtZoom: 13,
      showCoverageOnHover:     true,
      zoomToBoundsOnClick:     true,
      maxClusterRadius:        60,
      iconCreateFunction:      createClusterIcon
    })

    baseLayers = {
      "OpenStreetMap": osmLayer,
      "Bing Aerial": bingLayer
    }

    overlays = {
      "Show sites": @markers
    }

    L.control.layers(baseLayers, overlays).addTo(@map)

    @map.addControl(new L.FitBoundsControl({
      onClick: @fitBounds
    }))
