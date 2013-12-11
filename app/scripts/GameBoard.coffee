define [ 'require'
         'EaselJS'
         'Puck' ], (require) ->

  Puck = require 'Puck'

  class GameBoard

    constructor: (@stage, @options) ->
      createjs.Ticker.addEventListener 'tick', @tick

      @pucks = []

      # TEMP
      @addPuck()

    addPuck: ->
      puck = new Puck @stage.canvas.width / 2, 100, 'EUR', @options
      @pucks.push puck
      @stage.addChild puck.shape

    tick: (event) =>
      if not event.paused
        # add more pucks if needed

        # update pucks positions based on velocity
        for puck in @pucks
          puck.updatePosition event.delta

        # calculate collisions and correct course
        #  pucks to walls
        #  pucks to pucks
        # update score when pucks leave the board
        # check victory condition

        @stage.update()

