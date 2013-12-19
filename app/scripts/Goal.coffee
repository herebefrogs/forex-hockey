define [ 'require'
         'EaselJS'
         'TweenJS' ], (require) ->

  class Goal

    constructor: (@width, @height, flipped, @options) ->
      @currencies = []
      @score = 0

      @shape = new createjs.Container()
      @goal = new createjs.Shape()
      @scoreText = new createjs.Text @getScore(), 'bold 32px "Press Start 2P"', 'white'
      @currency = new createjs.Text "", 'bold 32px "Press Start 2P"', 'white'

      @scoreText.regX = @scoreText.getMeasuredWidth() / 2
      @scoreText.regY = @scoreText.getMeasuredLineHeight()
      @currency.regY = @scoreText.regY

      @scoreText.x = 50 + @scoreText.regX
      @scoreText.y = 16.25 + @scoreText.regY
      @currency.x = width - 150
      @currency.y = @scoreText.y
      @shape.regX = @width / 2
      @shape.regY = 32.5
      @shape.x = @shape.regX
      @goal.x = 0

      if flipped
        @shape.rotation = 180
        @shape.y = @shape.regY
        @goal.y = 0
      else
        @shape.y = height - @shape.regY
        @goal.y = height - 75

      @shape.addChild @scoreText
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

      previousScore = @score
      @score += @puckValue
      @currencies.push currency

      if @score > previousScore
        @scoreText.set
          text: @getScore currency
        createjs.Tween.get(@scoreText).to(
          scaleX: 2
          scaleY: 2
        , @options.scoreBounce, createjs.Ease.easeOut).to(
          scaleX: 1
          scaleY: 1
        , @options.scoreBounce, createjs.Ease.easeIn)

      @currency.set
        text: currency.text
      @goal.graphics.f(currency.color).dr(0, 0, @width, 75).ef()

    getScore: (currency) ->
      score = currency?.symbol or ''

      score += "#{@score}M"


