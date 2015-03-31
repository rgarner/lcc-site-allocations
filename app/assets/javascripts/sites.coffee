# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  if document.getElementById('map')
    $.ajax
      url: $('link[rel="alternate"][type="application/json"]').attr('href')
      dataType: "json"
      error: (jqXHR, textStatus, errorThrown) ->
        console.log("Couldn't get map JSON - #{textStatus}: #{errorThrown}")
        $('#map').remove()

      success: (data, textStatus, jqXHR) ->
        unless data.feature
          $('#map').remove()
          return

        map = L.map('map', {
          center: [53.801277, -1.548567],
          zoom: 12
        });
        L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
          attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
        }).addTo(map);

        feature = L.geoJson(
          data.feature,
          onEachFeature: (feature, layer) ->
            layer.bindPopup("""
              <h4>#{feature.properties.name}</h4>
              <strong>Score</strong>
              <span class="score">#{feature.properties.score}</span>
            """)
        )
        feature.addTo(map);
        map.fitBounds(feature.getBounds())
