# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
//= require chosen.jquery.min
$(document).on "page:change", ->
  $("#voting_option_user_id").chosen
    allow_single_deselect: true
