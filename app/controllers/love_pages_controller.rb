class LovePagesController < ApplicationController
  before_action :set_user, only: [:facebook]
  before_action :authenticate_user!, except: [:facebook]

  before_action :set_love_page, only: [:show, :update]

  def index
    respond_to do |format|
      format.html
      format.json { render json: current_user.love_pages }
    end
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

  def update
    @love_page.update(love_page_update_params.merge(slug: nil))
    head 200
  end

  private

  def love_page_update_params
    params.require(:love_page).permit(:title)
  end

  def invitation_id
    cookies["invitation_id"]
  end

  def love_page_id
    invitation_id ? Invitation.find_by_id(invitation_id).try(:love_page_id) : nil
  end

  def set_love_page
    @love_page = current_user.love_pages.friendly.find params[:id]
  end

  def recent_posts
    RecentPost.new(@love_page).page(params[:page].to_i)
  end

  def set_user
    @user = User.from_omniauth(omniauth_params)
  end

  #may try omiauth_data.info.try(:email)
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
