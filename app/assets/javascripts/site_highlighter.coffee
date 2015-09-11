#
# Manage the interactions between the map and the table:
#  * Highlight layers in the table when selected on the map
#  * Zoom to layers on the map when clicked in the table
#
class @SiteHighlighter
  constructor: (@featureMap, @tableRowSelector) ->
    @tableRows().each((index, row) =>
      if @featureMap.layerByRef($(row).attr('data-layer-ref'))
        $(row)
          .addClass('map-available')
          .on('click', @tableRowClicked)
          .find('a').on('click', (e) ->
            e.stopPropagation()
          )
      else
        $(row).addClass('not-on-map')
    )

    @leafletMap = @featureMap.getMap()
    @leafletMap.on('popupopen',  @popupOpened)


  tableRows: =>
    $(@tableRowSelector)

  popupOpened: (e) =>
    @highlightLayerWithRef(e.popup.options.layerRef)

  featureClassList = (layer) ->
    $(layer._container).find('path,.leaflet-marker-icon').get(0).classList

  unhighlight: (layer) ->
    if layer
      switch layer.feature.geometry.type
        when 'Polygon'
          featureClassList(layer).remove('highlight')
        when 'Point'
          layer.setZIndexOffset(0)
          $(layer._icon).removeClass('highlight')

  highlight: (layer) ->
    if layer
      switch layer.feature.geometry.type
        when 'Polygon'
          featureClassList(layer)?.add('highlight')
          layer.bringToFront()
          @leafletMap.fitBounds(layer.getBounds(), {padding: [100,100]})
        when 'Point'
          layer.setZIndexOffset(1000)
          @leafletMap.setView(layer.getLatLng(), 13)
          setTimeout ->
            $(layer._icon).addClass('highlight')
          , 500

  highlightLayerWithRef: (ref) ->
    layer = @featureMap.layerByRef(ref)
    if layer
      @unhighlight(@highlightedLayer)
      @tableRows().removeClass('highlighted')
      @highlightedLayer = layer
      @highlight(layer)
      $("#{@tableRowSelector}[data-layer-ref=#{ref}]").addClass('highlighted')

  tableRowClicked: (e) =>
    $row = $(e.currentTarget)
    @highlightLayerWithRef($row.attr('data-layer-ref'), $row)



