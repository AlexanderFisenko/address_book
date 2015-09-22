$(document).ready ->
  $(window).scroll ->
    if $(this).scrollTop() > 600
      $('.scrollToTop').fadeIn 1000
    else
      $('.scrollToTop').fadeOut 1000

  $('.scrollToTop').click ->
    $('html, body').animate { scrollTop: 0 }, 500
    false

  $('#add-phone').on 'click', ->
    $('.phones-fields').append '<div><input type="tel" name="contact[phones][]" id="contact_phones_" pattern="^\\+?\\d+$"></div>'
    false

  $('#add-email').on 'click', ->
    $('.emails-fields').append '<div><input type="email" name="contact[emails][]" id="contact_emails_"></div>'
    false