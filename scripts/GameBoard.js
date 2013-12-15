(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  define(['require', 'EaselJS', 'Goal', 'lodash', 'Puck'], function(require) {
    var GameBoard, Goal, Puck;
    Goal = require('Goal');
    Puck = require('Puck');
    return GameBoard = (function() {
      function GameBoard(stage, options) {
        this.stage = stage;
        this.options = options;
        this.tick = __bind(this.tick, this);
        createjs.Ticker.addEventListener('tick', this.tick);
        this.pucks = [];
        this.player1 = new Goal(this.stage.canvas.width, 0, true, this.options);
        this.player2 = new Goal(this.stage.canvas.width, this.stage.canvas.height, false, this.options);
        this.gameBoard = new createjs.Container();
        this.scoreBoard = new createjs.Container();
        this.scoreBoard.addChild(this.player1.shape);
        this.scoreBoard.addChild(this.player2.shape);
        this.stage.addChild(this.player1.goal);
        this.stage.addChild(this.player2.goal);
        this.stage.addChild(this.gameBoard);
        this.stage.addChild(this.scoreBoard);
        this.addPucks();
      }

      GameBoard.prototype.checkRates = function() {
        var draw, probability;
        if (this.pucks.length + 1 < this.options.maxPucks) {
          probability = (1 - this.pucks.length / this.options.maxPucks) / this.options.probabilityDivider;
          draw = Math.random();
          if (draw < probability) {
            return this.addPucks();
          }
        }
      };

      GameBoard.prototype.addPucks = function() {
        var baseIndex, currency, n, puck, quoteIndex, x, y, _i, _len, _ref, _results;
        baseIndex = Math.floor(Math.random() * this.options.currencies.length);
        quoteIndex = (baseIndex + 1) % this.options.currencies.length;
        _ref = [baseIndex, quoteIndex];
        _results = [];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          n = _ref[_i];
          x = (this.stage.canvas.width - 2 * this.options.puckRadius) * Math.random() + this.options.puckRadius;
          y = this.stage.canvas.height / 2 + this.stage.canvas.height * (2 * this.options.maxDistance * Math.random() - this.options.maxDistance);
          currency = this.options.currencies[n];
          puck = new Puck(x, y, currency, this.options);
          this.pucks.push(puck);
          _results.push(this.gameBoard.addChild(puck.shape));
        }
        return _results;
      };

      GameBoard.prototype.checkGoal = function() {
        var puck, remove, _i, _len, _ref;
        remove = [];
        _ref = this.pucks;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          puck = _ref[_i];
          if (puck.shape.y < -this.options.puckRadius * 0.75) {
            this.player1.add(puck.currency);
            ga('send', 'event', 'game', 'goal:player 1', "score:" + this.player1.score);
            this.gameBoard.removeChild(puck.shape);
            remove.push(puck);
            puck.reset();
          } else if (puck.shape.y > this.stage.canvas.height + this.options.puckRadius * 0.75) {
            this.player2.add(puck.currency);
            ga('send', 'event', 'game', 'goal:player 2', "score:" + this.player2.score);
            this.gameBoard.removeChild(puck.shape);
            remove.push(puck);
            puck.reset();
          }
        }
        return this.pucks = _.difference(this.pucks, remove);
      };

      GameBoard.prototype.checkVictory = function() {
        if (this.player1.score >= this.options.winningScore) {
          return this.options.winningCallback(1, this.player1.score);
        } else if (this.player2.score >= this.options.winningScore) {
          return this.options.winningCallback(2, this.player2.score);
        }
      };

      GameBoard.prototype.start = function() {
        return createjs.Ticker.setPaused(false);
      };

      GameBoard.prototype.stop = function() {
        var puck, _i, _len, _ref, _results;
        createjs.Ticker.setPaused(true);
        _ref = this.pucks;
        _results = [];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          puck = _ref[_i];
          _results.push(puck.reset());
        }
        return _results;
      };

      GameBoard.prototype.tick = function(event) {
        var i, otherPuck, puck, _i, _j, _k, _len, _len1, _len2, _ref, _ref1, _ref2;
        if (!event.paused) {
          this.checkRates();
          _ref = this.pucks;
          for (_i = 0, _len = _ref.length; _i < _len; _i++) {
            puck = _ref[_i];
            puck.updatePosition(event.delta);
          }
          _ref1 = this.pucks;
          for (i = _j = 0, _len1 = _ref1.length; _j < _len1; i = ++_j) {
            puck = _ref1[i];
            puck.checkWallCollision(this.stage.canvas.width);
            _ref2 = this.pucks;
            for (_k = 0, _len2 = _ref2.length; _k < _len2; _k++) {
              otherPuck = _ref2[_k];
              if (puck !== otherPuck) {
                puck.checkPuckCollision(otherPuck);
              }
            }
          }
          this.checkGoal();
          this.checkVictory();
          return this.stage.update();
        }
      };

      return GameBoard;

    })();
  });

}).call(this);
