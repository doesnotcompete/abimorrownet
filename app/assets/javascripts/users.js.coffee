# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
//= require 'datatables'
//= require 'dataTables.bootstrap'
$(document).on "page:change", ->
  $('#invited-users-table').dataTable
    processing: true
    serverSide: true
    ajax: $('#invited-users-table').data('source')
    pagingType: 'full_numbers'
    # optional, if you want full pagination controls.
    # Check dataTables documentation to learn more about
    # available options.
