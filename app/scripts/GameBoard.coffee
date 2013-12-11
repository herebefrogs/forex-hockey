define [ 'require'
         'EaselJS'
         'Puck' ], (require) ->

  Puck = require 'Puck'

  class GameBoard

    constructor: (@stage, @options) ->
      createjs.Ticker.addEventListener 'tick', @tick

      @pucks = []

      # give the 2 players something to start with
      @addPucks()

    checkRates: ->
      if @pucks.length + 1 < @options.maxPucks
        # the more pucks there are in play, the less likely one will be added
        probability = (1 - @pucks.length / @options.maxPucks) / @options.probabilityDivider
        draw = Math.random()

        @addPucks() if draw < probability

    addPucks: ->
      # randomly pick a currency (base) and the next one in the array (quote)
      baseIndex = Math.floor Math.random() * @options.currencies.length
      quoteIndex = (baseIndex + 1) % @options.currencies.length

      for n in [ baseIndex, quoteIndex]
        # calculate a random location toward the middle of the board
        x = (@stage.canvas.width - 2 * @options.puckRadius) * Math.random() + @options.puckRadius
        y = @stage.canvas.height  / 2 + @stage.canvas.height * ( 2 * @options.maxDistance * Math.random() - @options.maxDistance)

        # TODO need better randomization between the 2 pucks
        # TODO check this location is free

        currency = @options.currencies[n]

        puck = new Puck x, y, currency, @options
        @pucks.push puck
        @stage.addChild puck.shape

    tick: (event) =>
      if not event.paused
        # add more pucks if needed
        @checkRates()

        # update pucks positions based on velocity
        for puck in @pucks
          puck.updatePosition event.delta

        # calculate collisions and correct course
        #  pucks to walls
        #  pucks to pucks
        # update score when pucks leave the board
        # check victory condition

        @stage.update()

