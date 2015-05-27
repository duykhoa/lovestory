ready = ->
  console.log 'haha'

  $("#invite-link").bind "ajax:success", (event, data, status) ->
    $("#invitation_link__output").val(data.invitation_link)

$(document).ready(ready)
