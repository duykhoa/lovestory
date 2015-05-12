class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  devise :omniauthable, omniauth_providers: [:facebook]

  attr_accessor :uid, :provider

  has_many :accounts
  has_many :pages

  after_create :create_related_account
  after_create :create_page

  private

  def create_related_account
    accounts.create(provider: provider, uid: uid)
  end

  def create_page
    pages.create
  end
end
