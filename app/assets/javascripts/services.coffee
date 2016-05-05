# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  description_text = $('#description_text')
  counter = $('#counter')
  max_length = counter.data('maximum-length')
  description_text.keyup ->
    counter.text max_length - ($(this).val().length)
    return
  return
  event.preventDefault()