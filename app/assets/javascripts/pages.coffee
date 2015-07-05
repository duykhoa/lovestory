ready = ->
  $("#owl-carousel").owlCarousel({
    slideSpeed : 300,
    paginationSpeed : 400,
    singleItem:true,
    autoPlay: 5000,
    pagination: true
  })

  $("#invite-link").bind "ajax:success", (event, data, status) ->
    $("#invitation_link__output").val(data.invitation_link)

  s = skrollr.init(
    forceHeight: false
  )
$(document).ready(ready)
