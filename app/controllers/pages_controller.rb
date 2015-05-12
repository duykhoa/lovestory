class PagesController < ApplicationController
  before_action :set_user

  def facebook
    sign_in @user
    render json: { message: "Successfully login" }
  end

  private

  def set_user
    @user = Account.from_omniauth(omniauth_params)
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
    "#{SecureRandom.hex(4)}@email.com"
  end
end
