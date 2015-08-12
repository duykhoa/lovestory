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

  $(".invite-link-floating").bind "ajax:success", (event, data, status) ->
    $("#invitation-modal .invitation_link__output").val(data.invitation_link)
    $("#invitation-modal").openModal()

  if $('#skrollr-body').length > 0
    s = skrollr.init(
      forceHeight: false
    )

  $('[data-remodal-id=modal]').remodal()
  $('.button-collapse').sideNav()

  if $('.new-post-push-pin').count > 0
    $('.new-post-push-pin').pushpin({ top: $('.new-post-push-pin').offset().top - 85 })

$(document).ready(ready)
