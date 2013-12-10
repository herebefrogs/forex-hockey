define [ 'require'
         'EaselJS' ], (require) ->

  class Puck

    constructor: (x, y, @currency) ->
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

        @tap =
          x: e.stageX
          y: e.stageY

        @shape.addEventListener 'pressmove', @move
        @shape.addEventListener 'pressup', @release

        @render()

    move: (e) =>
      if @pointerId is e.pointerID
        @shape.x += (e.stageX - @tap.x)
        @shape.y += (e.stageY - @tap.y)

        @tap.x = e.stageX
        @tap.y = e.stageY

    release: (e) =>
      if @pointerId is e.pointerID
        delete @pointerId

        @shape.removeEventListener 'pressmove', @move
        @shape.removeEventListener 'pressup', @release

        @render()

    render: ->
      if not @pointerId?
          @circle.graphics.ss(10).s('white').f('#223').dc 0, 0, 75
      else
          @circle.graphics.f('white').dc 0, 0, 75

      @text.set
        color: if @pointerId? then '#223' else 'white'


