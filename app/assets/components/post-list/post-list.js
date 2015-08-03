Polymer({
  is: "post-list",
  ready: function() {
    currentObject = this
    $.ajax({
      url: "/love_pages/1.json",
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
