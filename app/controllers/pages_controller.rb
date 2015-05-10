class PagesController < ApplicationController
  def facebook
    render json: { message: request.env['omniauth.auth'] }
  end
end
