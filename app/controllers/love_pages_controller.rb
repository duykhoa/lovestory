class LovePagesController < ApplicationController
  before_action :set_user, only: [:facebook]
  before_action :authenticate_user!, only: [:show]
  before_action :set_love_page, only: [:show]
  before_action :set_recent_posts, only: [:show]

  def facebook
    sign_in @user

    @user.join_love_page(love_page_id)
    redirect_to @user.love_pages.first
  end

  def show
  end

  private

  def love_page_id
    invitation_id = cookies["invitation_id"]

    invitation_id ?  Invitation.find_by_id(invitation_id).try(:love_page_id) : nil
  end

  def set_love_page
    @love_page = current_user.love_pages.first
  end

  def set_recent_posts
    @posts = @love_page.posts
  end

  def set_user
    @user = User.from_omniauth(omniauth_params)
  end

  def omniauth_params
    {
      uid: omniauth_data.uid,
      email: omniauth_data.info.email || default_email,
      provider: "facebook"
    }
  end

  def omniauth_data
    request.env["omniauth.auth"]
  end

  def default_email
    "#{SecureRandom.hex(5)}@email.com"
  end
end
