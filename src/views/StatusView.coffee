class window.StatusView extends Backbone.View

id: 'status',
className: 'status',

template: _.template('<%= message %>'),

initialize: ->
  @render()

render: ->
  debugger
  @el.html(@template(@.attributes))

displayMessage: (@message) ->
  @render()
  return
