define [ 'require'
         'EaselJS'
         'TweenJS' ], (require) ->

  class Goal

    constructor: (@width, @height, flipped, @options) ->
      @currencies = []
      @score = 0

      @shape = new createjs.Container()
      @goal = new createjs.Shape()
      @millions = new createjs.Text @getScore(), 'bold 32px "Press Start 2P"', 'white'
      @currency = new createjs.Text "", 'bold 32px "Press Start 2P"', 'white'

      if flipped
        @millions.rotation = 180
        @millions.x = width - 50
        @currency.rotation = 180
        @currency.x = 150
        @millions.y = height + 50
        @currency.y = height + 50
        @goal.x = 0
        @goal.y = 0
      else
        @millions.x = 50
        @currency.x = width - 150
        @millions.y = height - 50
        @currency.y = height - 50
        @goal.x = 0
        @goal.y = height - 75

      @shape.addChild @millions
      @shape.addChild @currency


    add: (currency) ->
      if @currencies.length and currency is @currencies[@currencies.length - 1]
        if @puckValue is 0
          # 2nd currency of current streak
          @puckValue = 1
        else
          # 3rd+ currency of current streak
          @puckValue *= 2
      else
        # 1st currency of a new streak
        @puckValue = 0

      @score += @puckValue
      @currencies.push currency

      # TODO eye candy, make the million board wiggle with a tween
      @millions.set
        text: @getScore currency
      @currency.set
        text: currency.text
      @goal.graphics.f(currency.color).dr(0, 0, @width, 75).ef()

    getScore: (currency) ->
      score = currency?.symbol or ''

      score += "#{@score}M"


