class LovePagesController < ApplicationController
  before_action :set_user, only: [:facebook]
  before_action :authenticate_user!, except: [:facebook]

  before_action :set_love_page, only: [:show]

  def index
    @love_pages = current_user.love_pages
  end

  def facebook
    sign_in @user

    # TODO WIP refactor to command pattern
    JoinPage.new(@user, love_page_id).call
    remove_invitation_link
    remove_invitation_cookies

    if @user.love_pages.present?
      redirect_to @user.love_pages.first
    else
      redirect_to action: :index
    end
  end

  def show
    respond_to do |format|
      format.html
      format.json { render json: recent_posts, root: false }
    end
  end

  private

  def love_page_id
    invitation_id = cookies["invitation_id"]

    invitation_id ? Invitation.find_by_id(invitation_id).try(:love_page_id) : nil
  end

  def set_love_page
    @love_page = current_user.love_pages.find params[:id]
  end

  def recent_posts
    @love_page.posts #.includes(:assets, :user)
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

  def remove_invitation_link
    invitation_id = cookies["invitation_id"]
    Invitation.find_by_id(invitation_id).try :destroy
  end

  def remove_invitation_cookies
    cookies.delete "invitation_id"
  end

  def default_email
    "#{SecureRandom.hex(5)}@email.com"
  end
end
