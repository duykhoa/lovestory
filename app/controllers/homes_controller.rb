class HomesController < ApplicationController
  before_action :redirect_to_page

  def index
  end

  private

  def redirect_to_page
    redirect_to current_user.love_pages.first if user_signed_in?
  end
end
