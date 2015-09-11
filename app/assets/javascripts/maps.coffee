jQuery ->
  mapElement = document.getElementById('map')
  if mapElement
    $.ajax
      url: $('link[rel="alternate"][type="application/vnd.geo+json"]').attr('href')
      dataType: "json"
      error: (jqXHR, textStatus, errorThrown) ->
        console.log("Couldn't get map JSON - #{textStatus}: #{errorThrown}")
        $('.map-container').remove()
      success: (data_feature, textStatus, jqXHR) ->
        # data_feature can be type: 'Feature' or type: 'FeatureCollection'
        if data_feature.type == 'Feature' and !data_feature.geometry?
          $('.map-container').remove()
          return

        mapOptions = {
          fitMapToBounds: !MapStateManager.savedPosition()
        }

        window.map = if $(mapElement).hasClass('sites')
          map = new SitesMap(data_feature, mapOptions)
          new SiteHighlighter(map, '.sites tr.site')
          map
        else if $(mapElement).hasClass('allocations')
          map = new AllocationsMap(data_feature, mapOptions)
          new SiteHighlighter(map, '.allocations tr.allocation')
          map
        else
          throw "Unknown map type (sites or allocations) '#{$(mapElement).attr('class')}' given"

        new MapResizer(window.map.map).ready()
        new MapStateManager(window.map.map) if data_feature.type == 'FeatureCollection'
