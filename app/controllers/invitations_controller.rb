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
    if love_page
      ProcessLovePage
        .new(current_user, love_page.id, @invitation.id, cookies)
        .call

      redirect_to root_path(anchor: root_path_options) # fix the path
    else
      render status: 404
    end
  end

  private

  def love_page
    @love_page ||= @invitation.try(:love_page)
  end

  def root_path_options
    user_signed_in? ? nil : "signup-modal"
  end

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
