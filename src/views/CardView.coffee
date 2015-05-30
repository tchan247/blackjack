class window.CardView extends Backbone.View

  className: 'card'

  template: _.template ''

  initialize: ->
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template @model.attributes
    @$el.addClass 'covered' unless @model.get 'revealed'
    suitName = (@model.get 'suitName').toLowerCase()
    rankName = @model.get 'rankName'
    if @model.get 'revealed'
      @$el.css({'background-image': 'url(\'./img/cards/'+rankName+'-'+suitName+'.png\')'})
    else
      @$el.css({'background-image': 'url(\'./img/card-back.png\')'})







