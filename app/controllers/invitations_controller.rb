class InvitationsController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  before_action :set_love_page, only: [:create]

  def create
    invitation = Invitation
      .create(love_page_id: @love_page.id, user_id: current_user.id)

    invitation_path(invitation)
  end

  def show
  end

  private

  def set_love_page
    @love_page = LovePage.find love_page_id[:love_page_id]
  end

  def love_page_id
    params.permit(:love_page_id)
  end
end
