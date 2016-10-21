# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "turbolinks:load", ->
  $('.store .entry .product-images .list_image').click ->
    $(this).closest('div').find(':submit').click()
  $('.store .entry .product-images').find('img:first').siblings("img").hide()
