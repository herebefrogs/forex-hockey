require.config
  shim:
    TweenJS:
      deps: [ 'EaselJS' ]
      exports: 'createjs'

  paths:
    EaselJS: '../bower_components/EaselJS/lib/easeljs-0.7.1.min'
    SoundJS: '../bower_components/SoundJS/lib/soundjs-0.5.2.min'
    TweenJS: '../bower_components/TweenJS/lib/tweenjs-0.5.1.min'

require [ 'ForexHockey' ], () ->
  'use strict'

  ForexHockey = require 'ForexHockey'

  if not window.orientation?
    # laptop/desktop
    document.body.className = 'portrait'
  else
    # smartphone/tablet
    onOrientationChange = (mediaQuery) ->
      if mediaQuery.matches
        document.body.className = 'portrait'
      else
        document.body.className = 'landscape'

      # Mobile Safari doesn't update properly vw/vh used in CSS class 'screen'
      # after returning to portrait mode; yet body has correct dimensions
      # programmatically update width/height of visible 'screen' with body's
      id = document.body.getAttribute 'data-show'
      screen = document.getElementById id
      screen.style.width = document.body.clientWidth + 'px'
      screen.style.height = document.body.clientHeight + 'px'

    mediaQuery = window.matchMedia '(orientation: portrait)'

    mediaQuery.addListener onOrientationChange
    onOrientationChange mediaQuery

  start = document.getElementById('start').getElementsByTagName('button')[0]

  start.ontouchstart = ->
    start.classList.add 'pressed'

  # sound hack for mobile: closure to have a touch event
  # in the callstack when loading/playing files through SoundJS
  start.ontouchend = start.onmouseup = (e) ->
    start.classList.remove 'pressed'

    game = new ForexHockey()

    game.showGameScreen()

    # prevents mouseup from triggering if touchend is fired first
    e.preventDefault()

  setTimeout ( ->
    ForexHockey.prototype.showStartScreen()
  ), 3000
