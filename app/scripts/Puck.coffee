define [ 'require'
         'EaselJS' ], (require) ->

  class Puck

    constructor: (x, y, @currency, @options) ->
      @shape = new createjs.Container()
      @shape.x = x
      @shape.y = y

      @circle = new createjs.Shape()
      @text = new createjs.Text @currency, 'bold 32px "Press Start 2P"'
      @text.x = - @text.getMeasuredWidth() / 2
      @text.y = - @text.getMeasuredLineHeight() / 3

      @shape.addChild @circle
      @shape.addChild @text
      @shape.hitArea = @circle

      @render()

      @shape.addEventListener 'mousedown', @press

    press: (e) =>
      if not @pointerId?
        @pointerId = e.pointerID

        @vel =
          x: 0
          y: 0

        @tap =
          x: e.stageX
          y: e.stageY

        @time = createjs.Ticker.getTime()

        @shape.addEventListener 'pressmove', @move
        @shape.addEventListener 'pressup', @release

        @render()

    move: (e) =>
      if @pointerId is e.pointerID
        @vel.x = e.stageX - @tap.x
        @vel.y = e.stageY - @tap.y

        @tap.x = e.stageX
        @tap.y = e.stageY

        @shape.x += @vel.x
        @shape.y += @vel.y

        @time = createjs.Ticker.getTime()

        @render() if @options.debug

    release: (e) =>
      if @pointerId is e.pointerID
        delete @pointerId

        if createjs.Ticker.getTime() - @time > @options.stationaryTime
          # stayed stationary too long
          delete @vel
        else
          @vel.x *= @options.releaseBoost
          @vel.y *= @options.releaseBoost

        @shape.removeEventListener 'pressmove', @move
        @shape.removeEventListener 'pressup', @release

        @render()

    updatePosition: (delta) ->
      if not @pointerId? and @vel?
        @shape.x += @vel.x
        @shape.y += @vel.y

        remaining = (1 - @options.friction / delta)
        @vel.x *= remaining
        @vel.y *= remaining

    render: ->
      if not @pointerId?
        @circle.graphics.ss(10).s('white').f(@options.black).dc 0, 0, 75
        @text.set
          color: 'white'
      else
        @circle.graphics.f('white').dc 0, 0, 75
        @text.set
          color: @options.black

      if @options.debug
        @circle.graphics.ef().ss(4).s('red').mt(0, 0).lt(@vel.x, @vel.y) if @vel?
        @circle.graphics.es().ss(0).f('green').dc @tap.x - @shape.x, @tap.y - @shape.y, 25 if @tap?

