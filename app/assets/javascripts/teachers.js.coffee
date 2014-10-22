# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
//= require 'datatables'
//= require 'dataTables.bootstrap'
$(document).on "page:change", ->
  $('#teachers-table').dataTable
    processing: true
    serverSide: true
    ajax: $('#teachers-table').data('source')
    pagingType: 'full_numbers'
    language: {
      url: '//cdn.datatables.net/plug-ins/380cb78f450/i18n/German.json'
    }
