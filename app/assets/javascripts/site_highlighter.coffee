class @SiteHighlighter
  constructor: (@featureMap) ->
    # Adding '.map-available' styles the hover
    $('.sites tr.site')
      .addClass('map-available')
      .on('click', @siteRowClicked)
      .find('a').unbind('click')

  zoomToShlaaRef: (shlaaRef) ->
    layer = @featureMap.layerByShlaaRef(shlaaRef)
    feature = layer.feature
    switch feature.geometry.type
      when 'Point'
        @featureMap.getMap().setView(layer.getLatLng(), 13)
      when 'Polygon'
        @featureMap.getMap().fitBounds(layer.getBounds(), {padding: [100,100]})

  siteRowClicked: (e) =>
    @zoomToShlaaRef($(e.currentTarget).attr('data-shlaa-ref'))
