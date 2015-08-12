class User < ActiveRecord::Base
  devise :database_authenticatable, :rememberable, :trackable, :validatable
  devise :omniauthable, omniauth_providers: [:facebook]

  has_many :user_love_pages
  has_many :love_pages, through: :user_love_pages

  class << self
    def from_omniauth(uid: "", email: "", provider: "facebook")
      find_by_uid(uid) || create(uid: uid, provider: provider, email: email, password: SecureRandom.hex(25))
    end
  end

  def join_love_page(love_page_id)
    if love_page_id
      user_love_pages.create(love_page_id: love_page_id, user_id: id)
    else
      love_pages.create if love_pages.count.eql?(0)
    end
  end
end
