Forex Hockey
===========

A 2-player, multitouch game mashup of Air Hockey, Hungry Hungry Hippos and OANDA Forex rates where the winning player is congratulated by former OANDA CEO K Duker in person. Best enjoyed on iPad. Initially developed in 24 hours during OANDA's December 2013 hackathon.

Play Forex Hockey at [jerle76.github.io/forex-hockey/](http://jerle76.github.io/forex-hockey/)

It is a HTML5 reimplementation of Michael Brough's [O](http://mightyvision.blogspot.co.uk/2012/10/o.html). However instead of being random, the apparition of pucks onto the playfield is driven by the Forex market and prices of 3 currency pairs on the OANDA online Forex trading platform.

Game Rules
----------

The goal of Forex Hockey is to be the first to score 75 millions. Each player seats on a side of a tablet positioned in portrait mode. The top of the screen is the goal line of player #1, the bottom of the screen the one of player #2.

Pucks bearing one of the three currencies EUR (Euro), USD (US Dollar) and GBP (British Pound Sterling) appear at the center of the screen every time there is a new price for one of the three currency pairs EUR/USD, GBP/USD and GBP/EUR on the OANDA online Forex trading platform.

You score millions by sending pucks bearing the same currency through your goal line. The first puck is worth 0 million, the second 1 million and any puck after that twice as much as the previous puck. The longer the streak, the faster you will get to 75 millions.

You prevent your opponent from scoring by breaking his streak with a puck bearing a different currency, thus making him start a new streak and resetting the puck value to 0 million.

Tips
----

- This is a multitouch game: don't hesitate to use all your fingers to grab as many pucks as possible at the same time. Don't hesitate to "kung-fu" your opponent's fingers too!
- For better experience on iPad:
  - disable Multitasking Gestures under Settings > General. You may trigger a Pinch or Swipe Up gesture if you use four fingers or more. Nothing ruins a game like being sent back to the Home Screen!
  - add Forex Hockey to the Home Screen by clicking the Action button in Safari. You will maximize the playfield by getting rid of Safari's location and tab bars.

Getting started
---------------

This game was bootstraped using Yeoman, Grunt and Bower. Before you begin, download Nodejs then make sure Grunt and Bower are installed globally by running the following command:

> npm install -g grunt bower

Once you've checked out a fresh copy of this repository, install all the Nodejs and client-side library dependencies by running the following command from the root of the repository:

> npm install && bower install

To run the game:

> grunt serve
