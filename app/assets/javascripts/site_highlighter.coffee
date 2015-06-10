class @SiteHighlighter
  constructor: (@featureMap) ->
    siteRows().each((index, row) =>
      if @featureMap.layerByShlaaRef($(row).attr('data-shlaa-ref'))
        $(row)
          .addClass('map-available')
          .on('click', @siteRowClicked)
          .find('a').on('click', (e) ->
            e.stopPropagation()
          )
      else
        $(row).addClass('not-on-map')
    )

    @leafletMap = @featureMap.getMap()
    @leafletMap.on('popupopen',  @popupOpened)

  siteRows = ->
    $('.sites tr.site')

  popupOpened: (e) =>
    @highlightShlaaRef(e.popup.options.shlaaRef)

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

  highlightShlaaRef: (shlaaRef) ->
    layer = @featureMap.layerByShlaaRef(shlaaRef)
    if layer
      @unhighlight(@highlightedLayer)
      siteRows().removeClass('highlighted')
      @highlightedLayer = layer
      @highlight(layer)
      $(".sites .site[data-shlaa-ref=#{shlaaRef}]").addClass('highlighted')

  siteRowClicked: (e) =>
    $row = $(e.currentTarget)
    @highlightShlaaRef($row.attr('data-shlaa-ref'), $row)



