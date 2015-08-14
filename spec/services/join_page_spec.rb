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
        context "love_page with love_page_id doesn't exist" do
          let(:love_page_id) { 999 }

          before do
            expect(UserLovePage.count).to eq 0
            user.reload
          end

          context "user doesn't have any love_page" do
            before do
              join_page_service.call
            end

            it "create new love_page for user" do
              is_expected.to eq 1
            end
          end

          context "user had love_page already" do
            before do
              create(:love_page, user: user)
            end

            it "doesn't create new love_page for user" do
              expect(user.love_pages).to(
                receive(:create!)
                  .exactly(0)
                  .times
              )

              join_page_service.call
            end

            after do
              user.reload
              expect(user.love_pages.count).to eq(1)
              expect(user.user_love_pages.count).to eq(1)
            end
          end
        end

        context "love_page exist" do
          let!(:love_page) { create(:love_page) }
          let(:love_page_id) { love_page.id }
          let(:service_call) { join_page_service.call }

          context "user has no love_page" do
            before do
              expect(user.love_pages).to be_empty
              join_page_service.call
            end

            it "add love_pages for user" do
              expect(user.love_pages.count).to eq 1
            end
          end

          context "user has another love page" do
            let!(:love_page) { create(:love_page, user: user) }

            before do
              expect(user.love_pages.count).to eq 1
              join_page_service.call
            end

            it "doesn't add new love page" do
              expect(user.love_pages.count).to eq 1
            end
          end

          context "user owned love page" do
            let!(:another_love_page) { create(:love_page, user: user) }

            before do
              is_expected.to eq 1
              join_page_service.call
            end

            it "add love_pages for user" do
              expect(user.love_pages.count).to eq 2
            end
          end
        end
      end
    end

    context "user doesn't exist" do
      let(:join_page_service) { JoinPage.new(user, love_page_id) }
      subject { join_page_service.call }

      context "user is nil" do
        let(:user) { nil }
        let(:love_page) { create(:love_page) }
        let(:love_page_id) { love_page.id }

        it "returns nil" do
          is_expected.to be nil
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
