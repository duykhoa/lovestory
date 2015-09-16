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

  if $('.new-post-push-pin').length > 0
    $('.new-post-push-pin').pushpin({ top: $('.new-post-push-pin').offset().top - 85 })

  images = [
    "https://raw.githubusercontent.com/duykhoa/lovestory-assets/master/slide1.jpg"
    "https://raw.githubusercontent.com/duykhoa/lovestory-assets/master/slide2.jpg"
    "https://raw.githubusercontent.com/duykhoa/lovestory-assets/master/slide3.jpg"
  ]

  $.preload(images, 1, (last) ->
    index = images.indexOf(this[0])
    $('<img src="' + this[0] + '" alt="" />').prependTo(".slide#slide" + index);

    if (last)
      $("#preload").addClass("hide")
  )

  $('form#new_asset #asset_photo').change () ->
    formData = new FormData(document.querySelector("form#new_asset"))

    $.ajax({
      type: 'post'
      url: '/assets'
      data: formData
      processData: false
      contentType: false
      success: (data) ->
        $(".photo-attachments").append('<input name="photo_ids[]" type="hidden" value=' + data.id + '>')
    })

$(document).ready(ready)
