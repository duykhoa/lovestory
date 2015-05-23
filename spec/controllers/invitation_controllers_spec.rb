require "rails_helper"

describe InvitationsController do
  let!(:user) { create(:user) }
  let(:love_page) { { love_page_id: user.love_page.id } }

  context "login user" do
    before { sign_in user }

    describe "POST create" do
      it "returns successful status"  do
        post :create, love_page

        expect(response.status).to eq 200
      end
    end
  end

  context "non-login user" do
    describe "POST create" do
      it "returns un authorize status"  do
        post :create, love_page

        expect(response.status).to eq 302
      end
    end
  end
end
