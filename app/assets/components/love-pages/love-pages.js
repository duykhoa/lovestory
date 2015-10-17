Polymer({
  is: "love-pages",
  ready: function() {
    currentObject = this;
    $.ajax({
      url: "/love_pages.json",
      success: function(lovePages) {
        currentObject.lovePages = lovePages.love_pages
      }
    });
  }
});
