# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on "page:change", ->
  $("#ticket_ticket_preference_associations_attributes_0_profile_id").chosen
    allow_single_deselect: true
  $("#ticket_ticket_preference_associations_attributes_1_profile_id").chosen
    allow_single_deselect: true
  $("#ticket_ticket_preference_associations_attributes_2_profile_id").chosen
    allow_single_deselect: true