class Post < ActiveRecord::Base
  default_scope { order created_at: :desc }

  belongs_to :love_page
  belongs_to :user

  has_many :assets, dependent: :destroy

  attr_accessor :photo_ids
end
