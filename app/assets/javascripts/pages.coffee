ready = ->
  $(".owl-carousel").owlCarousel({
    items: 1
    loop: true
    mouseDrag: true
    touchDrag: true
    autoplay: true
    autoplayTimeout: 5000
    autoplayHoverPause: true
    smartSpeed: 800
  })

  $("#invite-link").bind "ajax:success", (event, data, status) ->
    $("#invitation_link__output").val(data.invitation_link)

  #s = skrollr.init(
    #forceHeight: false
  #)

  $('[data-remodal-id=modal]').remodal()
  #$('#nav').sticky()
  $(".button-collapse").sideNav()
$(document).ready(ready)
