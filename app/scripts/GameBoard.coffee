define [ 'require'
         'EaselJS'
         'Puck' ], (require) ->

  Puck = require 'Puck'

  class GameBoard

    constructor: (@stage) ->
      createjs.Ticker.addEventListener 'tick', @tick

      puck = new Puck @stage.canvas.width / 2, 100, 'EUR'
      console.log puck, @stage
      @stage.addChild puck.shape
      @stage.update()

    tick: (event) =>
      if not event.paused
        # add more pucks if needed
        # update pucks positions based on velocity
        # calculate collisions and correct course
        #  pucks to walls
        #  pucks to pucks
        # update score when pucks leave the board
        # check victory condition

        @stage.update()


