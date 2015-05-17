require "rails_helper"

describe User do
  it { should have_one(:love_page) }

  describe "create new page after create new user" do
    before do
      expect(User.count).to eq 0
      expect(LovePage.count).to eq 0
    end

    it "creates new user" do
      create(:user)
    end

    after do
      expect(LovePage.count).to eq 1
    end
  end
end
