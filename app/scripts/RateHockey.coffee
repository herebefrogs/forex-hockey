define [ 'require'
         'EaselJS'
         'GameBoard'
         'SoundJS' ], (require) ->

  GameBoard = require 'GameBoard'

  class RateHockey

    constructor: ->
      # initialize sound system and load sound assets
      if not createjs.Sound.initializeDefaultPlugins()
        console.error 'createjs.Sound failed to initialize'
        return

      createjs.Sound.registerSound 'sounds/worldklass.mp3', 'worldklass'

      # initialize graphic system
      stage = new createjs.Stage 'canvas'
      createjs.Touch.enable stage
      createjs.Ticker.setPaused true

      @board = new GameBoard stage,
        # TODO set to false for demo
        debug: true
        black: '#223'
        puckRadius: 75
        currencies: [ 'EUR', 'GBP', 'USD' ]
        symbols:
          EUR: '€'
          GBP: '£'
          USD: '$'
        winningCallback: @showVictoryScreen
        # TODO set to 75 for demo
        winningScore: 3
        # percentage of velocity loss per second when gliding freely
        friction: 0.15
        # percentage of velocity remaining when colliding
        collisionFriction: 0.80
        # magic velocity multiplier when releasing puck
        releaseBoost: 2
        # delta in ms between move and release event above which the puck lost all its velocity
        stationaryTime: 250
        # max distance from board centre in percentage where puck can be added
        maxDistance: 0.10
        # max number of puck in play at anytime
        maxPucks: 6
        # puck creation probability divider
        probabilityDivider: 20
        # time in ms for a puck to appear once created
        puckFadeIn: 750

    showGameScreen: ->
      $('body').attr 'data-show', 'game'

      createjs.Ticker.setPaused false

    showVictoryScreen: (player) =>
      $('body').attr 'data-show', 'victory'

      instance = createjs.Sound.play 'worldklass',
        volume: 1

      if instance.playState is createjs.Sound.PLAY_FAILED
        console.error 'createjs.Sound failed to play mp3'

