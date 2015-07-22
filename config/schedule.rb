every 1.day, at: "00:00" do
  runner "Invitation.remove_expired_link"
end
