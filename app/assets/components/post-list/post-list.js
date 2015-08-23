Polymer({
  is: "post-list",
  properties: {
    pageId: {
      type: String
    },
    currentUserId: {
      type: String
    }
  },
  ready: function() {
    currentObject = this
    $.ajax({
      url: "/love_pages/" + currentObject.pageId + ".json",
      success: function(data) {
        currentObject.data = data;
        $(".preloader-wrapper").addClass("hide");
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
  },
  editLink: function(id) {
    return "/posts/" + id + "/edit"
  },
  deleteLink: function(id) {
    return "/posts/" + id
  },
  author: function(item) {
    return item.user_id == this.currentUserId
  }
});
