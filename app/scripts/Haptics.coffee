define [ ], () ->
  _vibrate = window.navigator.vibrate ? (->)

  vibrate: (duration) ->
    _vibrate.call window.navigator, duration
