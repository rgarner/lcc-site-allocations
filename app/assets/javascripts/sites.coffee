jQuery ->
  if document.getElementById('map')
    $.ajax
      url: $('link[rel="alternate"][type="application/vnd.geo+json"]').attr('href')
      dataType: "json"
      error: (jqXHR, textStatus, errorThrown) ->
        console.log("Couldn't get map JSON - #{textStatus}: #{errorThrown}")
        $('#map').remove()
      success: (data_feature, textStatus, jqXHR) ->
        window.map = new FeatureMap(data_feature)
        new SiteHighlighter(window.map)
