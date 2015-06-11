@FitBoundsControl = L.Control.extend({
  options: {
    position: 'topleft'
  },
  initialize: (options) ->
    @options.onClick = options.onClick
  onAdd: (map) ->
    controlDiv = L.DomUtil.create('div', 'leaflet-bar leaflet-fit-bounds leaflet-control')
    link = L.DomUtil.create('a', 'leaflet-clickable', controlDiv)
    link.href = '#'
    link.title = 'Fit sites to map'

    glyphIcon = L.DomUtil.create('span', 'glyphicon glyphicon-screenshot', link)

    if @options.onClick?
      L.DomEvent
        .addListener(link, 'click', L.DomEvent.stopPropagation)
        .addListener(link, 'click', L.DomEvent.preventDefault)
        .addListener(link, 'click', @options.onClick)

    controlDiv
})
