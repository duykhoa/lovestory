require "rails_helper"

describe User do
  it { should have_many(:accounts) }

  describe ".from_omniauth" do
    subject { User.from_omniauth(uid: "1234") }

    it "returns a user" do
      is_expected.to be_a(User)
    end
  end
end
