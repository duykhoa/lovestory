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
  updateTitleFormSubmit: function(e) {
    currentObject = this;
    e.preventDefault();
    form = e.target;
    fd = new FormData(form);

    $.ajax ({
      type: 'post',
      url: form.action,
      data: fd,
      processData: false,
      contentType: false,
      success: function() {
        currentObject.editMode = false;
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
  },
  toggleEditMode: function() {
    this.editMode = !this.editMode
  },
  CSRFToken: function() {
    return $("meta[name=csrf-token]").attr("content");
  },
  updateTitleUrl: function() {
    return "/love_pages/" + this.data.id;
  },
});
