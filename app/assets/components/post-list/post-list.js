Polymer({
  is: "post-list",
  properties: {
    pageId: {
      type: String
    }
  },
  ready: function() {
    currentObject = this
    $.ajax({
      url: "/love_pages/" + this.pageId + ".json",
      success: function(data) {
        currentObject.data = data;
      }
    })
  },
  postShowUrl: function(id) {
    return "/posts/" + id
  },
  fbImage: function(uid) {
    return "https://graph.facebook.com/" + uid + "/picture"
  },
  timeAgoValue: function(time) {
    return $.timeago(time)
  }
});
