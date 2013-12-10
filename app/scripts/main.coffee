require.config
  shim:
    TweenJS:
      deps: [ 'EaselJS' ]
      exports: 'createjs'

  paths:
    EaselJS: '../bower_components/EaselJS/lib/easeljs-0.7.0.min'
    jquery: '../bower_components/jquery/jquery.min'
    SoundJS: '../bower_components/SoundJS/lib/soundjs-0.5.1.min'
    TweenJS: '../bower_components/TweenJS/lib/tweenjs-0.5.0.min'

require ['jquery', 'RateHockey' ], () ->
  'use strict'

  RateHockey = require 'RateHockey'

  # sound hack for mobile: closure to have a touch event
  # in the callstack when loading/playing files through SoundJS

  # TODO uncomment... bypassed to develop faster
  #$('#splash').on 'click', ->
  game = new RateHockey()

  game.showGameScreen()
