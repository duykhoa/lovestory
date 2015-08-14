Polymer({
  is: "invitation-link",
  properties: {
    love_page_id: {
      type: String
    }
  },
  createInvitationLink: function() {
    currentObject = this

    $.post(this.love_page_id + "/invitations", function (data) {
      currentObject.invitationLink = data.invitation_link
    })
  },
  selectAll: function() {
    $("#result-link").select();
  }
});
