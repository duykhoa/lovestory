class Account < ActiveRecord::Base
  belongs_to :user

  class << self
    def from_omniauth(uid: "", email: "", provider: "facebook")
      find_by_uid(uid).try(:user) || create_user(uid: uid, provider: provider, email: email)
    end

    private

    def create_user(options)
      User.create options(options)
    end

    def options(opts = {})
      opts.merge(password: SecureRandom.hex(25))
    end
  end
end
