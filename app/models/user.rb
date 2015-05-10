class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  devise :omniauthable, omniauth_providers: [:facebook]

  has_many :accounts

  class << self
    def from_omniauth(uid: "", provider: "facebook")
      matched_account = Account.find_by(uid: uid)

      return matched_account.user if matched_account

      User.new(email: 'st@gmail.com', password: 'abcdefghik', name: 'dkll')
    end
  end
end
