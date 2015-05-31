require "rails_helper"

describe User do
  it { should have_many(:love_pages).through(:user_love_pages) }

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

  #TODO
  describe "#join_love_page" do
    pending

    context "love_page_id is nil" do
      it "does not add user to the love_page" do
      end
    end

    context "love_page_id is available" do
      it "does not add user to the love_page" do
      end
    end

    context "love_page_id is not available" do
      it "does not add user to the love_page" do
      end
    end
  end
end
