# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
ready = ->
  $('.remove-quote').on 'ajax:complete', ->
    $(this).parent().after("<em>Kommentar gelöscht.</em><hr />")
    $(this).parent().toggle("blind")
  $('.approve-quote').on 'ajax:success', ->
    $(this).parent().after("<em>Kommentar freigegeben.</em><hr />")
    $(this).parent().toggle("highlight", {color: "#91e374"})

$(document).ready(ready)
$(document).on('page:load', ready)
