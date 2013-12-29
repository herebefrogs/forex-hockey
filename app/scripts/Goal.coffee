define [ 'require'
         'EaselJS'
         'TweenJS' ], (require) ->

  class Goal

    constructor: (@id, @width, @height, flipped, @options) ->
      @currencies = []
      @score = 0

      @shape = new createjs.Container()
      @goal = new createjs.Shape()
      @scoreText = new createjs.Text @getScore(), 'bold 32px "Press Start 2P"', 'white'
      @valueText = new createjs.Text "  ", 'bold 32px "Press Start 2P"', 'white'
      @currency = new createjs.Text "   ", 'bold 32px "Press Start 2P"', 'white'

      @updateCurrencyAndValueX()
      @scoreText.regX = @scoreText.getMeasuredWidth() / 2
      @scoreText.regY = @scoreText.getMeasuredLineHeight()
      @valueText.regY = @scoreText.regY
      @currency.regY = @scoreText.regY

      @scoreText.x = 50 + @scoreText.regX
      @scoreText.y = 16.25 + @scoreText.regY
      @valueText.y = @scoreText.y
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
      @shape.addChild @valueText
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
      @score = Math.min @score + @puckValue, @options.winningScore
      @currencies.push currency

      if @score > previousScore
        @scoreText.set
          text: @getScore currency
        @animate @scoreText

      # show the value of the next puck to go
      @valueText.set
        text: "X#{2*@puckValue or 1}"
      @currency.set
        text: currency.text

      @updateCurrencyAndValueX()
      @animate @valueText

      @goal.graphics.f(currency.color).dr(0, 0, @width, 75).ef()

    updateCurrencyAndValueX: ->
      @valueText.regX = @valueText.getMeasuredWidth() / 2
      @valueText.x = @width - 50 - @valueText.regX
      @currency.x = @valueText.x - @valueText.regX - 25 - @currency.getMeasuredWidth()

    animate: (text) ->
      createjs.Tween.get(text).to(
        scaleX: 2
        scaleY: 2
      , @options.scoreBounce, createjs.Ease.easeOut).to(
        scaleX: 1
        scaleY: 1
      , @options.scoreBounce, createjs.Ease.easeIn)

    getScore: (currency) ->
      score = currency?.symbol or ''

      score += "#{@score}M"


