Polymer({
  is: "love-pages",
  ready: function() {
    currentObject = this;
    $.ajax({
      url: "/love_pages.json",
      success: function(lovePages) {
        console.log(lovePages.love_pages[0]);
        currentObject.lovePages = lovePages.love_pages
      }
    })
  },
  timeAgoValue: function(time) {
    return $.timeago(time);
  }
});
