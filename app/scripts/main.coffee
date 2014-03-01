require.config
  shim:
    TweenJS:
      deps: [ 'EaselJS' ]
      exports: 'createjs'

  paths:
    EaselJS: '../bower_components/EaselJS/lib/easeljs-0.7.1.min'
    SoundJS: '../bower_components/SoundJS/lib/soundjs-0.5.2.min'
    TweenJS: '../bower_components/TweenJS/lib/tweenjs-0.5.1.min'

require [ 'RateHockey' ], () ->
  'use strict'

  RateHockey = require 'RateHockey'

  setTimeout ( ->
    RateHockey.prototype.showStartScreen()
  ), 3000

  start = document.getElementById('start').getElementsByTagName('button')[0]

  start.ontouchstart = ->
    start.classList.add 'pressed'

  # sound hack for mobile: closure to have a touch event
  # in the callstack when loading/playing files through SoundJS
  start.ontouchend = start.onmouseup = (e) ->
    start.classList.remove 'pressed'

    game = new RateHockey()

    game.showGameScreen()

    # prevents mouseup from triggering if touchend is fired first
    e.preventDefault()
