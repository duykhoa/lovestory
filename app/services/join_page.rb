class JoinPage
  attr_accessor :user, :love_page_id

  def initialize(user, love_page_id)
    @user = user
    @love_page_id = love_page_id
  end

  def call
    return nil unless user && user.persisted?

    if love_page_id && love_page
      user.love_pages << love_page
      user.save!
      user
    end
  end

  private

  def love_page
    LovePage.find_by_id(love_page_id)
  end
end
