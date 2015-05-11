class PagesController < ApplicationController
  def facebook
    account = Account.from_omniauth(omniauth_params)

    render json: { message: account.inspect }
  end

  private

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
