class Post < ActiveRecord::Base
  default_scope { order created_at: :desc }

  belongs_to :love_page
  belongs_to :user

  has_many :assets
  accepts_nested_attributes_for :assets
end
