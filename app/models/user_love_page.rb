class UserLovePage < ActiveRecord::Base
  belongs_to :love_page
  belongs_to :user
end
