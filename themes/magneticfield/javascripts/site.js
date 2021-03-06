$.facebox.settings.closeImage = '/theme/images/closelabel.png'
$.facebox.settings.loadingImage = '/theme/images/loading.gif'

$(document).ready(function($) {

  $('a[rel=facebox]').facebox()

  $('#events .event .title').bind('click', function() { 
    $(this).siblings('.more').slideToggle('slow'); 
  })

  $('#filters .filter').bind('click', function() {
    $(this).toggleClass('active')
    $(this).siblings().removeClass('active')
    $('#events .event').hide()
    $('#events .event.'+$(this).attr('rel')).toggle()
  })

})
