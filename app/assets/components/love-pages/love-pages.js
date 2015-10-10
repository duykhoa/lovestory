Polymer({
  is: "love-pages",
  ready: function() {
    currentObject = this;
    $.ajax({
      url: "/love_pages.json",
      success: function(lovePages) {
        currentObject.lovePages = lovePages.love_pages
      }
    })
  },
  timeAgoValue: function(time) {
    return $.timeago(time);
  },
  fbImageUrl: function(uid) {
    return "https://graph.facebook.com/" + uid + "/picture"
  },
  dropDownID: function(id) {
    return "dropdown-menu-" + id;
  }
});
