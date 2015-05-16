class Post < ActiveRecord::Base
  default_scope { order created_at: :desc }

  belongs_to :love_page
end
