class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  devise :omniauthable, omniauth_providers: [:facebook]

  has_many :accounts

  class << self
    def from_omniauth(uid: "", provider: "facebook")
      new
    end
  end
end
