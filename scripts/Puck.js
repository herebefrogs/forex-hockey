(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  define(['require', 'EaselJS', 'TweenJS'], function(require) {
    var Puck;
    return Puck = (function() {
      function Puck(x, y, currency, options) {
        this.currency = currency;
        this.options = options;
        this.release = __bind(this.release, this);
        this.move = __bind(this.move, this);
        this.press = __bind(this.press, this);
        this.shape = new createjs.Container();
        this.shape.x = x;
        this.shape.y = y;
        this.shape.scaleX = 0;
        this.shape.scaleY = 0;
        this.vel = {
          x: 0,
          y: 0
        };
        this.circle = new createjs.Shape();
        this.text = new createjs.Text(this.currency.text, 'bold 32px "Press Start 2P"');
        this.text.x = -this.text.getMeasuredWidth() / 2;
        this.text.y = -this.text.getMeasuredLineHeight() / 3;
        this.shape.addChild(this.circle);
        this.shape.addChild(this.text);
        this.shape.hitArea = this.circle;
        this.render();
        createjs.Tween.get(this.shape).to({
          scaleX: 1,
          scaleY: 1
        }, this.options.puckFadeIn, createjs.Ease.elasticOut);
        this.shape.addEventListener('mousedown', this.press);
      }

      Puck.prototype.press = function(e) {
        if (this.pointerId == null) {
          this.pointerId = e.pointerID;
          this.vel = {
            x: 0,
            y: 0
          };
          this.tap = {
            x: e.stageX,
            y: e.stageY
          };
          this.time = createjs.Ticker.getTime();
          this.shape.addEventListener('pressmove', this.move);
          this.shape.addEventListener('pressup', this.release);
          return this.render();
        }
      };

      Puck.prototype.move = function(e) {
        if (this.pointerId === e.pointerID) {
          this.vel.x = e.stageX - this.tap.x;
          this.vel.y = e.stageY - this.tap.y;
          this.tap.x = e.stageX;
          this.tap.y = e.stageY;
          this.shape.x += this.vel.x;
          this.shape.y += this.vel.y;
          this.time = createjs.Ticker.getTime();
          if (this.options.debug) {
            return this.render();
          }
        }
      };

      Puck.prototype.release = function(e) {
        if (this.pointerId === e.pointerID) {
          delete this.pointerId;
          if (createjs.Ticker.getTime() - this.time > this.options.stationaryTime) {
            this.vel = {
              x: 0,
              y: 0
            };
          } else {
            this.vel.x *= this.options.releaseBoost;
            this.vel.y *= this.options.releaseBoost;
          }
          this.shape.removeEventListener('pressmove', this.move);
          this.shape.removeEventListener('pressup', this.release);
          return this.render();
        }
      };

      Puck.prototype.updatePosition = function(delta) {
        var remaining;
        if ((this.pointerId == null) && (this.vel != null)) {
          this.shape.x += this.vel.x;
          this.shape.y += this.vel.y;
          remaining = 1 - this.options.friction / delta;
          this.vel.x *= remaining;
          return this.vel.y *= remaining;
        }
      };

      Puck.prototype.checkWallCollision = function(boardWidth) {
        var offset;
        if (this.shape.x < this.options.puckRadius) {
          offset = this.options.puckRadius - this.shape.x;
        } else if (this.shape.x > boardWidth - this.options.puckRadius) {
          offset = boardWidth - this.options.puckRadius - this.shape.x;
        }
        if (offset != null) {
          this.shape.x += offset;
          if (this.pointerId != null) {
            this.tap.x += offset;
          }
          this.vel.x = -this.vel.x * this.options.collisionFriction;
          return this.vel.y *= this.options.collisionFriction;
        }
      };

      Puck.prototype.checkPuckCollision = function(puck) {
        var cos, deltaX, deltaY, distance, offset, offsetX, offsetY, ratio, sin, x, y;
        deltaX = this.shape.x - puck.shape.x;
        deltaY = this.shape.y - puck.shape.y;
        distance = Math.sqrt(Math.pow(deltaX, 2) + Math.pow(deltaY, 2));
        if (distance < 2 * this.options.puckRadius) {
          cos = Math.abs(deltaX / distance);
          sin = Math.abs(deltaY / distance);
          x = this.vel.x * cos + this.vel.y * cos;
          y = -this.vel.x * sin + this.vel.y * cos;
          offset = ((2 * this.options.puckRadius) - distance) / 2;
          ratio = offset / distance;
          offsetX = deltaX * ratio;
          offsetY = deltaY * ratio;
          this.shape.x += offsetX;
          this.shape.y += offsetY;
          if (this.pointerId != null) {
            this.tap.x += offsetX;
            this.tap.y += offsetY;
          }
          if ((deltaX > 0 && deltaY > 0) || (deltaX < 0 && deltaY < 0)) {
            x = -x * this.options.collisionFriction;
            y *= this.options.collisionFriction;
          } else {
            y = -y * this.options.collisionFriction;
            x *= this.options.collisionFriction;
          }
          this.vel.x = x * cos - y * sin;
          return this.vel.y = x * sin + y * cos;
        }
      };

      Puck.prototype.reset = function() {
        return this.release({
          pointerID: null
        });
      };

      Puck.prototype.render = function() {
        if (this.pointerId == null) {
          this.circle.graphics.ss(2 * this.options.puckBorder).s('white').f(this.currency.color).dc(0, 0, this.options.puckRadius - this.options.puckBorder).es().ef();
          this.text.set({
            color: 'white'
          });
        } else {
          this.circle.graphics.f('white').dc(0, 0, this.options.puckRadius).ef();
          this.text.set({
            color: this.currency.color
          });
        }
        if (this.options.debug) {
          if (this.vel != null) {
            this.circle.graphics.ef().ss(4).s('red').mt(0, 0).lt(this.vel.x, this.vel.y);
          }
          if (this.tap != null) {
            return this.circle.graphics.es().ss(0).f('green').dc(this.tap.x - this.shape.x, this.tap.y - this.shape.y, 25);
          }
        }
      };

      return Puck;

    })();
  });

}).call(this);
