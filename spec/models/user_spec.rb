require "rails_helper"

describe User do
  it { should have_many(:accounts) }
  it { should have_one(:page) }

  describe "create new page after create new user" do
    before do
      expect(User.count).to eq 0
      expect(Account.count).to eq 0
      expect(Page.count).to eq 0
    end

    it "creates new user" do
      create(:user)
      expect(User.count).to eq 1
    end

    after do
      expect(Account.count).to eq 1
      expect(Page.count).to eq 1
    end
  end
end
