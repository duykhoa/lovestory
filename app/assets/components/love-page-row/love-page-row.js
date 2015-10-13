Polymer({
  is: "love-page-row",
  properties: {
    data: {
      type: Object
    }
  },
  ready: function() {
    this.editMode = false;
    setTimeout(function(){
      $('.dropdown-button').dropdown();
    }, 100);
  },
  timeAgoValue: function(time) {
    return $.timeago(time);
  },
  fbImageUrl: function(uid) {
    return "https://graph.facebook.com/" + uid + "/picture"
  },
  dropDownID: function(id) {
    return "dropdown-menu-" + id;
  },
  toggleEditMode: function() {
    this.editMode = !this.editMode
  }
});
