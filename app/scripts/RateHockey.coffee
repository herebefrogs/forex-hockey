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
        debug: true
        black: '#223'
        # percentage of velocity loss per second
        friction: 0.15
        # magic velocity multiplier when releasing puck
        releaseBoost: 2
        # delta in ms between move and release event above which the puck lost all its velocity
        stationaryTime: 250

    showGameScreen: ->
      $('body').attr 'data-show', 'game'

      createjs.Ticker.setPaused false

    showVictoryScreen: ->
      $('body').attr 'data-show', 'victory'

      instance = createjs.Sound.play 'worldklass',
        volume: 1

      if instance.playState is createjs.Sound.PLAY_FAILED
        console.error 'createjs.Sound failed to play mp3'

