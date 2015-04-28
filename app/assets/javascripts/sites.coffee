jQuery ->
  if document.getElementById('map')
    $.ajax
      url: $('link[rel="alternate"][type="application/vnd.geo+json"]').attr('href')
      dataType: "json"
      error: (jqXHR, textStatus, errorThrown) ->
        console.log("Couldn't get map JSON - #{textStatus}: #{errorThrown}")
        $('#map').remove()

      success: (data_feature, textStatus, jqXHR) ->
        getIconName = (s) ->
          if      -58 <= s <= -11 then 'very-negative'
          else if -10 <= s <=  -1 then 'negative'
          else if        s == 0   then 'neutral'
          else if   1 <= s <= 10  then 'positive'
          else if  11 <= s <= 58  then 'very-positive'
          else 'no-score'

        ColorMarker = L.Icon.extend({ options: {
          shadowUrl: '/assets/marker-shadow.png'
          iconSize: [25, 41], # size of the icon
          iconAnchor: [12, 40], # point of the icon which will correspond to marker's location
          popupAnchor: [1, -40] # point from which the popup should open relative to the iconAnchor
        }})

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
              <span class="score label #{ if site.score? then getIconName(site.score) else ''}">#{if site.score? then site.score else 'N/A'}</span>
            """)
          pointToLayer: (feature, latlng) ->
            iconName = getIconName(feature.properties.score)
            icon = new ColorMarker({
              iconUrl:       "/assets/#{iconName}.png",
              iconRetinaUrl: "/assets/#{iconName}2x.png"
            })
            return L.marker(latlng, { icon: icon })
        )

        markers.addLayer(featureLayer)
        markers.addTo(map);

        options = if data_feature.type == 'Feature' && data_feature.geometry.type == 'Point' then { maxZoom: 15 } else {}

        # Cope with race condition causing map freeze. Decorous 50ms grace given
        setTimeout ( ->
          map.fitBounds(markers.getBounds(), options)
        ), 50

