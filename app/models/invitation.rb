class Invitation < ActiveRecord::Base
  EXPIRED_IN = 12.hours

  default_scope { where { created_at.gt EXPIRED_IN.ago } }
  scope :expired, -> { where { created_at.lteq EXPIRED_IN.ago } }

  belongs_to :user
  belongs_to :love_page

  def self.remove_expired_link
    expired.destroy_all
  end
end
