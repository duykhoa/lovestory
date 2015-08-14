class InvitationsController < ApplicationController
  before_action :authenticate_user!, :set_love_page, only: [:create]
  before_action :set_invitation, only: [:show]

  def create
    invitation = Invitation.create(
      love_page_id: @love_page.id,
      user_id: current_user.id
    )

    render json: { invitation_link: invitation_url(invitation) }
  end

  def show
    page = @invitation.try :love_page

    if page
      if current_user
        JoinPage.new(current_user, page.id).call
        Invitations::Remove.new(@invitation.id, cookies).call

        redirect_to root_path # FIXME: later
      else
        cookies['invitation_id'] = @invitation.id
        redirect_to root_path(anchor: "signup-modal")
      end
    else
      render status: 404
    end
  end

  private

  def set_invitation
    @invitation = Invitation.find_by(id: invitation_id[:id])
  end

  def love_page_id
    params.permit(:love_page_id)
  end

  def invitation_id
    params.permit(:id)
  end

  def set_love_page
    @love_page = LovePage.find love_page_id[:love_page_id]
  end
end
