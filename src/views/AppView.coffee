class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button><button class="stand-button">Stand</button><button class="bet-button">Bet</button><button class="continue-button" disabled>Continue</button><button class="restart-button" disabled>Restart</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    'click .stand-button': -> @model.get('playerHand').stand()
    'click .continue-button': ->
      @model.handleContinue()
      @render()
      return
    'click .restart-button': ->
        @model.handleRestart()
        @render()
        return
    'click .bet-button': ->
        @model.handleBet()
        @render()
        return

  initialize: ->
    @model.on 'playerWin', @handlePlayerWin, @
    @model.on 'playerLost', @handlePlayerLost, @
    @model.on 'dealerWin', @handleDealerWin, @
    @model.on 'tie', @handleTie, @
    @render()
    @toggleButtonOn()
    return

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
    #debugger;
    @$el.append new StatusView( model: message: @model.get 'status').$el
    @$('.continue-button').attr("disabled", "disabled")
    @$('.restart-button').attr("disabled", "disabled")

  handlePlayerWin: ->
    @toggleButtonOff()
    alert("You WIN!!!")

  handlePlayerLost: ->
    @toggleButtonOff()
    alert("You LOSE!!!")

  handleDealerWin: ->
    @toggleButtonOff()
    alert("Dealer WIN!!!")

  handleTie: ->
    @toggleButtonOff()
    alert("You didn't Lose, nor did you win!!!")

  toggleButtonOff: ->
    @$('.hit-button').attr("disabled", "disabled")
    @$('.stand-button').attr("disabled", "disabled")
    @$('.continue-button').removeAttr('disabled')
    @$('.restart-button').removeAttr('disabled')

  toggleButtonOn: ->
    @$('.hit-button').removeAttr('disabled')
    @$('.stand-button').removeAttr('disabled')
    @$('.continue-button').attr("disabled", "disabled")
    @$('.restart-button').attr("disabled", "disabled")
