class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  devise :omniauthable, omniauth_providers: [:facebook]

  attr_accessor :uid, :provider

  has_many :accounts
  has_one :love_page

  after_create :create_related_account
  after_create :create_new_page

  private

  def create_related_account
    accounts.create(provider: provider, uid: uid)
  end

  def create_new_page
    create_love_page
  end
end
