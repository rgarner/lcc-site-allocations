jQuery ->
  if document.getElementById('map')
    $.ajax
      url: $('link[rel="alternate"][type="application/vnd.geo+json"]').attr('href')
      dataType: "json"
      error: (jqXHR, textStatus, errorThrown) ->
        console.log("Couldn't get map JSON - #{textStatus}: #{errorThrown}")
        $('#map').remove()

      success: (data_feature, textStatus, jqXHR) ->
        # data_feature can be type: 'Feature' or type: 'FeatureCollection'
        if data_feature.type == 'Feature' and !data_feature.geometry?
          $('#map').remove()
          return

        map = L.map('map', {
          center: [53.801277, -1.548567],
          zoom: 12,
          scrollWheelZoom: false
        });

        L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
          attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
        }).addTo(map);

        markers = new L.MarkerClusterGroup({
          disableClusteringAtZoom: 14,
          showCoverageOnHover: true,
          zoomToBoundsOnClick: true,
          maxClusterRadius: 60,
          iconCreateFunction: (cluster) ->
            children = cluster.getChildCount()
            return new L.DivIcon(
              {
                className: "leaflet-div-icon cluster",
                html: """
                  <div class="cluster-inner"><div class="cluster-count">#{children}</div></div>
                """
              }
            )
        })

        featureLayer = L.geoJson(
          data_feature,
          onEachFeature: (feature, layer) ->
            site = feature.properties # for readability in the template
            layer.bindPopup("""
              <h4><a href="/sites/#{site.shlaa_ref}">#{site.name}</a></h4>
              <strong>Score</strong>
              <span class="score">#{if site.score? then site.score else 'N/A'}</span>
            """)
        )
        markers.addLayer(featureLayer)
        markers.addTo(map);

        options = if data_feature.type == 'Feature' && data_feature.geometry.type == 'Point' then { maxZoom: 15 } else {}
        map.fitBounds(markers.getBounds(), options)
