# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/



jQuery ($) ->
  $('.phone').mask '(999) 999-9999'
  $('.date').mask '99/99/9999'
  return

$(document).ready ->
  $('.click_show').click ->
    $(this).next('.section').slideToggle("fast")
    $(this).find('.glyphicon').toggle()
    return
  return
  event.preventDefault()

$(document).ready ->
  $('.click_show_important').click ->
    $(this).next('.important_section').slideToggle("fast")
    $(this).find('.glyphicon').toggle()


    return
  return
  event.preventDefault()

jQuery ($) ->
  $('.thumb').hover ->
    $(this).next('.big_image').toggle()
  return


$('.owl-carousel').owlCarousel()






