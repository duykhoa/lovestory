class LovePagesController < ApplicationController
  before_action :set_user, only: [:facebook]
  before_action :authenticate_user!, except: [:facebook]

  before_action :set_love_page, only: [:show]

  def index
    @love_pages = current_user.love_pages
  end

  def facebook
    sign_in @user

    JoinPage.new(@user, love_page_id).call
    Invitations::Remove.new(invitation_id, cookies).call

    if @user.love_pages.present?
      # FIXME: return to page#index if has > 1 page
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

  def invitation_id
    cookies["invitation_id"]
  end

  def love_page_id
    invitation_id ? Invitation.find_by_id(invitation_id).try(:love_page_id) : nil
  end

  def set_love_page
    @love_page = current_user.love_pages.find params[:id]
  end

  def recent_posts
    @love_page.posts.includes(:assets, :user)
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
