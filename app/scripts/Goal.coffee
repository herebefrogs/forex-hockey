define [ 'require'
         'EaselJS'
         'TweenJS' ], (require) ->

  class Goal

    constructor: (width, height, flipped, @options) ->
      @currencies = []
      @score = 0

      @shape = new createjs.Container()
      @millions = new createjs.Text @getScore(), 'bold 32px "Press Start 2P"', 'white'
      @currency = new createjs.Text "", 'bold 32px "Press Start 2P"', 'white'

      if flipped
        @millions.rotation = 180
        @millions.x = width - 50
        @currency.rotation = 180
        @currency.x = 150
      else
        @millions.x = 50
        @currency.x = width - 150

      @millions.y = height
      @currency.y = height

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
        text: currency

    getScore: (currency) ->
      score = @options.symbols[currency] or '' 

      score += "#{@score}M"

      
