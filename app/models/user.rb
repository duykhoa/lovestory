class User < ActiveRecord::Base
  devise :database_authenticatable, :rememberable, :trackable, :validatable

  devise :omniauthable, omniauth_providers: [:facebook]

  has_one :love_page

  after_create :create_new_page

  class << self
    def from_omniauth(uid: "", email: "", provider: "facebook")
      find_by_uid(uid) || create(uid: uid, provider: provider, email: email, password: SecureRandom.hex(25))
    end
  end

  def join_love_page(love_page_id)
  end

  private

  def create_new_page
    create_love_page
  end
end
