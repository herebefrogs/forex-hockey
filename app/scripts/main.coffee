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

require [], () ->
  'use strict'
