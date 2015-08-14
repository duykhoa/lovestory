module Invitations
  class Remove
    COOKIES_NAME = "invitation_id"

    attr_reader :invitation_id, :cookies

    def initialize(invitation_id, cookies)
      @invitation_id = invitation_id
      @cookies = cookies
    end

    def call
      invitation.try :destroy
      remove_invitation_cookies
    end

    private

    def remove_invitation_cookies
      cookies.delete COOKIES_NAME
    end

    def invitation
      Invitation.find_by_id(invitation_id)
    end
  end
end
