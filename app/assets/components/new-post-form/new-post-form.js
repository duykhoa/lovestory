Polymer({
  is: "new-post-form",
  properties: {
    pageId: {
      type: String
    }
  },
  ready: function() {
    this.photos = [];
  },
  createPostUrl: function(id) {
    return "/love_pages/" + id + "/posts"
  },
  CSRFToken: function() {
    $("meta[name=csrf-token]").attr("content")
  },
  submitForm: function() {
    currentObject = this
    formData = new FormData(document.querySelector("form[name=new_asset]"))

    $.ajax({
      type: 'post',
      url: '/assets',
      data: formData,
      processData: false,
      contentType: false,
      beforeSend: function() {
        $('#new-post-submit-button').addClass("disabled");
      },
      success: function(data) {
        $('#new-post-submit-button').removeClass("disabled");
        currentObject.photos = currentObject.photos.concat([data])
      }
    })
  }
});
