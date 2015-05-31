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

  describe "#join_love_page" do
    let!(:user) { create(:user) }
    let!(:love_page) { create(:love_page) }

    context "love_page_id is nil" do
      let(:love_page_id) { nil }

      it "does not add user to the love_page" do
        expect { user.join_love_page(love_page_id) }.to change { user.love_pages.count }.by(0)
      end
    end

    context "love_page_id is available" do
      let(:love_page_id) { love_page.id }

      it "add user to the love_page" do
        expect { user.join_love_page(love_page_id) }.to change { user.love_pages.count }.by(1)
      end
    end

    context "love_page_id is available but no page with this love_page_id exist" do
      pending "doesn't do anything"
    end
  end
end
