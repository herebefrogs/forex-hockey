(function() {
  define(['require', 'EaselJS', 'TweenJS'], function(require) {
    var Goal;
    return Goal = (function() {
      function Goal(width, height, flipped, options) {
        this.width = width;
        this.height = height;
        this.options = options;
        this.currencies = [];
        this.score = 0;
        this.shape = new createjs.Container();
        this.goal = new createjs.Shape();
        this.millions = new createjs.Text(this.getScore(), 'bold 32px "Press Start 2P"', 'white');
        this.currency = new createjs.Text("", 'bold 32px "Press Start 2P"', 'white');
        this.millions.regX = this.millions.getMeasuredWidth() / 2;
        this.millions.regY = this.millions.getMeasuredHeight() / 2;
        if (flipped) {
          this.millions.rotation = 180;
          this.millions.x = width - 50 - this.millions.regX;
          this.currency.rotation = 180;
          this.currency.x = 150;
          this.millions.y = height + 50 - this.millions.regY;
          this.currency.y = height + 50;
          this.goal.x = 0;
          this.goal.y = 0;
        } else {
          this.millions.x = 50 + this.millions.regX;
          this.currency.x = width - 150;
          this.millions.y = height - 50 + this.millions.regY;
          this.currency.y = height - 50;
          this.goal.x = 0;
          this.goal.y = height - 75;
        }
        this.shape.addChild(this.millions);
        this.shape.addChild(this.currency);
      }

      Goal.prototype.add = function(currency) {
        if (this.currencies.length && currency === this.currencies[this.currencies.length - 1]) {
          if (this.puckValue === 0) {
            this.puckValue = 1;
          } else {
            this.puckValue *= 2;
          }
        } else {
          this.puckValue = 0;
        }
        this.score += this.puckValue;
        this.currencies.push(currency);
        this.millions.set({
          text: this.getScore(currency)
        });
        createjs.Tween.get(this.millions).to({
          scaleX: 2,
          scaleY: 2
        }, this.options.scoreBounce, createjs.Ease.easeOut).to({
          scaleX: 1,
          scaleY: 1
        }, this.options.scoreBounce, createjs.Ease.easeIn);
        this.currency.set({
          text: currency.text
        });
        return this.goal.graphics.f(currency.color).dr(0, 0, this.width, 75).ef();
      };

      Goal.prototype.getScore = function(currency) {
        var score;
        score = (currency != null ? currency.symbol : void 0) || '';
        return score += "" + this.score + "M";
      };

      return Goal;

    })();
  });

}).call(this);
