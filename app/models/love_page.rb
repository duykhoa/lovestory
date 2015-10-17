class LovePage < ActiveRecord::Base
  has_many :posts

  has_many :user_love_pages
  has_many :users, through: :user_love_pages

  extend FriendlyId
  friendly_id :title, use: :slugged
end
