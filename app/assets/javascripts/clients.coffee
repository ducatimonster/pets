# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#jQuery ->
#
#  $('.client_name').autocomplete
#    source: $('.client_name').data('autocomplete-source')
#




jQuery ($) ->
  $('.add_new').click ->
    $(this).parent().find('.phone').each ->
      $('.phone').mask '(999) 999-9999'
    return
  return
  event.preventDefault()





jQuery ($) ->
  $('.phone').mask '(999) 999-9999'
  $('.date').mask '99/99/9999'
  return



jQuery ($) ->
  $('.phone').mask '(999) 999-9999'
  $('.date').mask '99/99/9999'
  return


jQuery ($) ->
  $('.thumb_client').hover ->
    $(this).next('.big_image_client').toggle()
  return
