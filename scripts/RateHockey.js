(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  define(['require', 'EaselJS', 'GameBoard', 'SoundJS'], function(require) {
    var GameBoard, RateHockey;
    GameBoard = require('GameBoard');
    return RateHockey = (function() {
      function RateHockey() {
        this.showVictoryScreen = __bind(this.showVictoryScreen, this);
        var stage;
        if (!createjs.Sound.initializeDefaultPlugins()) {
          console.error('createjs.Sound failed to initialize');
          return;
        }
        createjs.Sound.registerSound('sounds/worldklass.mp3', 'worldklass');
        stage = new createjs.Stage('canvas');
        createjs.Touch.enable(stage);
        createjs.Ticker.setFPS(60);
        createjs.Ticker.setPaused(true);
        this.board = new GameBoard(stage, {
          debug: false,
          black: '#223',
          puckRadius: 85,
          puckBorder: 5,
          currencies: [
            {
              text: 'EUR',
              symbol: '€',
              color: '#2b2'
            }, {
              text: 'GBP',
              symbol: '£',
              color: '#b22'
            }, {
              text: 'USD',
              symbol: '$',
              color: '#22b'
            }
          ],
          winningCallback: this.showVictoryScreen,
          winningScore: 75,
          friction: 0.15,
          collisionFriction: 0.80,
          releaseBoost: 2,
          stationaryTime: 250,
          maxDistance: 0.10,
          maxPucks: 6,
          probabilityDivider: 20,
          puckFadeIn: 750,
          scoreBounce: 250
        });
      }

      RateHockey.prototype.showGameScreen = function() {
        ga('send', 'pageview', '/rate-hockey/game');
        $('body').attr('data-show', 'game');
        return this.board.start();
      };

      RateHockey.prototype.showVictoryScreen = function(player, score) {
        var instance;
        ga('send', 'pageview', '/rate-hockey/victory');
        ga('send', 'event', 'game', "victory:player " + player, "score:" + score);
        this.board.stop();
        $('body').attr('data-show', 'victory');
        instance = createjs.Sound.play('worldklass', {
          volume: 1
        });
        if (instance.playState === createjs.Sound.PLAY_FAILED) {
          return console.error('createjs.Sound failed to play mp3');
        }
      };

      return RateHockey;

    })();
  });

}).call(this);
