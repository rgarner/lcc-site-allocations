class @MapResizer
  constructor: (@leaflet_map) ->
    throw 'No map given' unless @leaflet_map?

  invalidateMapSize: () =>
    @leaflet_map.invalidateSize()

  collapsePanelExpandMap = ->
    $('#filters-panel-collapser .glyphicon')
      .addClass('glyphicon-triangle-bottom')
      .removeClass('glyphicon-triangle-top')
    $('#map').addClass('expanded')

  collapseMapExpandPanel = ->
    $('#filters-panel-collapser .glyphicon')
      .addClass('glyphicon-triangle-top')
      .removeClass('glyphicon-triangle-bottom')
    $('#map').removeClass('expanded')

  ready: () ->
    $('#filters-panel').on('hide.bs.collapse', collapsePanelExpandMap)
    $('#filters-panel').on('hidden.bs.collapse', @invalidateMapSize)

    $('#filters-panel').on('show.bs.collapse', collapseMapExpandPanel)
    $('#filters-panel').on('shown.bs.collapse', @invalidateMapSize)
