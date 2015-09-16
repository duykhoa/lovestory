Polymer({
  is: "new-post-form",
  properties: {
    pageId: {
      type: String
    }
  },
  ready: function() {
  },
  createPostUrl: function(id) {
    return "/love_pages/" + id + "/posts"
  },
  CSRFToken: function() {
    $("meta[name=csrf-token]").attr("content")
  }
});
