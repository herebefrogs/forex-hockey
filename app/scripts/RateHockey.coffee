define [ 'require'
         'SoundJS' ], (require) ->

  class RateHockey

    constructor: ->
      # initialize sound system and load sound assets
      if not createjs.Sound.initializeDefaultPlugins()
        console.error 'createjs.Sound failed to initialize'
        return

      createjs.Sound.registerSound 'sounds/worldklass.mp3', 'worldklass'

    showVictoryScreen: ->
      $('body').attr 'data-show', 'victory'

      instance = createjs.Sound.play 'worldklass',
        volume: 1
        loop: 2

      if instance.playState is createjs.Sound.PLAY_FAILED
        console.error 'createjs.Sound failed to play mp3'


