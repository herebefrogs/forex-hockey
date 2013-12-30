require.config
  shim:
    TweenJS:
      deps: [ 'EaselJS' ]
      exports: 'createjs'

  paths:
    EaselJS: '../bower_components/EaselJS/lib/easeljs-0.7.1.min'
    jquery: '../bower_components/jquery/jquery.min'
    lodash: '../bower_components/lodash/dist/lodash.min'
    SoundJS: '../bower_components/SoundJS/lib/soundjs-0.5.2.min'
    TweenJS: '../bower_components/TweenJS/lib/tweenjs-0.5.1.min'

require ['jquery', 'RateHockey' ], () ->
  'use strict'

  RateHockey = require 'RateHockey'

  setTimeout ( ->
    RateHockey.prototype.showStartScreen()
  ), 3000

  # sound hack for mobile: closure to have a touch event
  # in the callstack when loading/playing files through SoundJS

  $('#start button').on 'click', ->
    game = new RateHockey()

    game.showGameScreen()
