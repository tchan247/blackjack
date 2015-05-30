class window.StatusView extends Backbone.View

className: 'status'

template: _.template '<% message %>'
#template: _.template 'Testing'

initialize: ->
  @render()

render: ->
  debugger
  @el.html @template @model.attributes
  #@el.html 'Testing'
  return

displayMessage: (@message) ->
  @render()
  return
