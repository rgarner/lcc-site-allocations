#
# Restore to position serialised in window.location.hash on creation
# Save state to same hash when the map is moved
#
class @MapStateManager
  STATE_FORMAT = ///
    (-?[0-9]{1,3}\.[0-9]{1,30}), # Lat
    (-?[0-9]{1,3}\.[0-9]{1,30}); # Lng
    ([0-9]{1,2})                 # Zoom
  ///

  constructor: (@leafletMap) ->
    @leafletMap.on('moveend', @finishedRestoring)
    positionToRestore = MapStateManager.savedPosition()
    if positionToRestore?
      @restore(positionToRestore)
    else
      @finishedRestoring

  @savedPosition = ->
    match = window.location.hash.match(STATE_FORMAT)
    return null unless match?

    position = {}
    position.center = L.latLng(match[1], match[2])
    position.zoom   = match[3]
    position

  serialize = (position) ->
    "#{position.center.lat},#{position.center.lng};#{position.zoom}"

  saveState = (position) ->
    history.replaceState(undefined, undefined, "##{serialize(position)}")

  finishedRestoring: (e) =>
    @leafletMap.off('moveend', @finishedRestoring)
    @leafletMap.on( 'moveend', @leafletMoveEnd)

  restore: (position) ->
    @leafletMap.setView(position.center, position.zoom)

  leafletMoveEnd: (e) =>
    saveState(
      {
        center: @leafletMap.getCenter(),
        zoom:   @leafletMap.getZoom()
      }
    )
