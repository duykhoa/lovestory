class Invitation < ActiveRecord::Base
  EXPIRED_IN = 12.hours

  default_scope { where { created_at.gt EXPIRED_IN.ago } }

  belongs_to :user
end
