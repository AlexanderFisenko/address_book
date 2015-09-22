$(document).ready ->
  $(window).scroll ->
    if $(this).scrollTop() > 600
      $('.scrollToTop').fadeIn 1000
    else
      $('.scrollToTop').fadeOut 1000
    return

  $('.scrollToTop').click ->
    $('html, body').animate { scrollTop: 0 }, 500
    false
  return