require 'soft_deletion'

class Post < ActiveRecord::Base
  has_soft_deletion default_scope: true
  default_scope { order created_at: :desc }

  belongs_to :love_page
  belongs_to :user

  has_many :assets, dependent: :destroy
  has_many :images, dependent: :destroy

  attr_accessor :photo_ids
end
