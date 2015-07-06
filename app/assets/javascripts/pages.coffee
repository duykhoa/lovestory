ready = ->
  $("#owl-carousel").owlCarousel({
    slideSpeed : 1000,
    paginationSpeed : 700,
    transitionStyle : "fade",
    singleItem:true,
    autoPlay: 5000,
    pagination: true
  })

  $("#invite-link").bind "ajax:success", (event, data, status) ->
    $("#invitation_link__output").val(data.invitation_link)

  s = skrollr.init(
    forceHeight: false
  )

  $('[data-remodal-id=modal]').remodal()
$(document).ready(ready)
