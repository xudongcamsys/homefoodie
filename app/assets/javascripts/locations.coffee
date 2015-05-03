# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

update_location = (lat, lng) ->
  $.ajax
    type: 'PATCH'
    url: '/location'
    data: 
      lat: lat
      lng: lng

window.track_location = track_location = ->
  navigator.geolocation.getCurrentPosition (position) ->
    update_location position.coords.latitude, position.coords.longitude