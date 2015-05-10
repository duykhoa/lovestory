require "rails_helper"

describe User do
  it { should have_many(:accounts) }

  let(:uid) { "1234567890" }

  describe ".from_omniauth" do
    subject { User.from_omniauth(uid: uid) }

    context "account is exist in db" do
      let!(:user) { create(:user) }
      let!(:account) { create(:account, uid: uid, user: user) }

      it "returns persisted user" do
        is_expected.to eq(user)
        expect(subject.persisted?).to be true
      end
    end

    context "account is not exist in db" do
      it "returns a new user" do
        is_expected.to be_a(User)

        expect(subject.persisted?).to be false
      end
    end
  end
end
