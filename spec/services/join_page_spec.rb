require "rails_helper"

describe JoinPage do
  describe ".new" do
    let(:user) { build(:user) }
    let(:love_page_id) { 1 }

    it "init new join_page object" do
      expect(JoinPage.new(user, love_page_id)).to be_a(JoinPage)
    end
  end

  describe "#call" do
    let(:join_page_service) { JoinPage.new(user, love_page_id) }

    context "user exists" do
      let!(:user) { create(:user) }

      subject { user.love_pages.count }

      context "love_page_id exist" do
        context "love_page with love_page_id isn't exist" do
          let(:love_page_id) { 999 }

          before do
            expect(UserLovePage.count).to eq 0
            join_page_service.call
            user.reload
          end

          it "does not add new love page to user's love_pages" do
            is_expected.to eq 0
          end
        end

        context "love_page exist" do
          let!(:love_page) { create(:love_page) }
          let(:love_page_id) { love_page.id }
          let(:service_call) { join_page_service.call }

          before do
            expect(user.love_pages).to be_empty
            user.reload

            service_call
          end

          it "add love_pages for user" do
            is_expected.to eq 1
          end

          it "returns user" do
            expect(service_call).to eq(user)
          end
        end
      end
    end

    # more context
    context "user doesn't exist" do
      let(:join_page_service) { JoinPage.new(user, love_page_id) }
      subject { join_page_service.call }

      context "user is nil" do
        let(:user) { nil }

        context "love_page with love_page_id exist" do
          let(:love_page) { create(:love_page) }
          let(:love_page_id) { love_page.id }

          it "returns nil" do
            is_expected.to be nil
          end
        end

        context "love_page isn't exist" do
          let(:love_page_id) { 999 }

          it "returns nil" do
            is_expected.to be nil
          end
        end
      end

      context "user isn't persistent" do
        let(:user) { build(:user) }
        let(:love_page_id) { 999 }

        it "returns nil" do
          is_expected.to be nil
        end
      end
    end
  end
end
