class User < ActiveRecord::Base
  devise :database_authenticatable, :rememberable, :trackable, :validatable

  devise :omniauthable, omniauth_providers: [:facebook]

  has_many :user_love_pages
  has_many :love_pages, through: :user_love_pages

  after_create :create_new_page

  class << self
    def from_omniauth(uid: "", email: "", provider: "facebook")
      find_by_uid(uid) || create(uid: uid, provider: provider, email: email, password: SecureRandom.hex(25))
    end
  end

  def join_love_page(love_page_id)
    if love_page_id
      user_love_pages.create(love_page_id: love_page_id, user_id: id)
    end
  end

  private

  def create_new_page
    #FIXME: not automatically create love_page
    love_pages.create
  end
end
