# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

updateUserLocation = (lat, lng) ->
  $.ajax
    type: 'PATCH'
    url: '/location'
    data: 
      lat: lat
      lng: lng

window.getLocation = getLocation = (callback, isTrack)->
  success = (pos) ->
    if callback
      callback pos

  error = (err) ->
    console.warn 'Failed to get location: ' + err.message

  navigator.geolocation.getCurrentPosition success, error

  if isTrack
    # navigator.geolocation.clearWatch
    navigator.geolocation.watchPosition success, error    


window.trackLocation = trackLocation = ->
  getLocation (position) ->
    updateUserLocation position.coords.latitude, position.coords.longitude