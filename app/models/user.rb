class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  devise :omniauthable, omniauth_providers: [:facebook]

  attr_accessor :uid, :provider

  has_many :accounts

  after_create :create_related_account

  private

  def create_related_account
    accounts.create(provider: provider, uid: uid)
  end
end
