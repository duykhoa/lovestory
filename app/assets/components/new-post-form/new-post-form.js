Polymer({
  is: "new-post-form",
  properties: {
    pageId: {
      type: String
    }
  },
  createPostUrl: function(id) {
    return "/love_pages/" + id + "/posts"
  },
  CSRFToken: function() {
    $("meta[name=csrf-token]").attr("content")
  },
  submitForm: function() {
    formData = new FormData(document.querySelector("form[name=new_asset]"))

    $.ajax({
      type: 'post',
      url: '/assets',
      data: formData,
      processData: false,
      contentType: false,
      success: function(data) {
        $(".photo-attachments").append('<input name="photo_ids[]" type="hidden" value=' + data.id + '>')
      }
    })
  }
});
