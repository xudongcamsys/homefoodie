# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

updateLocation = (lat, lng) ->
  $.ajax
    type: 'PATCH'
    url: '/location'
    data: 
      lat: lat
      lng: lng

window.trackLocation = trackLocation = ->
  navigator.geolocation.getCurrentPosition (position) ->
    updateLocation position.coords.latitude, position.coords.longitude