# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @set 'status', "This is a status message"
    (@get 'playerHand').on 'bust', @handlePlayerBusted, @
    (@get 'playerHand').on 'stand', @handlePlayerStand, @
    (@get 'dealerHand').on 'bust', @handleDealerBusted, @
    return

  handlePlayerBusted: ->
    @trigger 'playerLost', @
    return

  handleDealerBusted: ->
    @trigger 'playerWin', @
    return

  handlePlayerStand: ->
    dealer = @get 'dealerHand'
    playerScore = (@get 'playerHand').scores()[1] > 21 ?
    playerHighestScore = if (playerScore[1] > 21) then playerScore[0] else playerScore[1]

    dealer.at(0).flip()

    while dealer.scores()[0] < playerHighestScore || dealer.scores()[0] < 17
      dealer.hit()

    if dealer.scores()[0] == playerHighestScore
      @trigger 'tie', @
      return
    else
      @trigger 'dealerWin', @
      return

  handleContinue: ->
    deck = @get 'deck'
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    (@get 'playerHand').on 'bust', @handlePlayerBusted, @
    (@get 'playerHand').on 'stand', @handlePlayerStand, @
    (@get 'dealerHand').on 'bust', @handleDealerBusted, @
    return

  handleRestart: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    (@get 'playerHand').on 'bust', @handlePlayerBusted, @
    (@get 'playerHand').on 'stand', @handlePlayerStand, @
    (@get 'dealerHand').on 'bust', @handleDealerBusted, @
    return



