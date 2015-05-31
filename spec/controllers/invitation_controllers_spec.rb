require "rails_helper"

describe InvitationsController do
  let!(:user) { create(:user) }
  let(:love_page) { { love_page_id: user.love_pages.first.id } }

  describe "POST create" do
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

  describe "GET show" do
    let!(:invitation) { create(:invitation) }
    let(:user) { invitation.user }
    let(:page) { invitation.love_page }

    context "valid invitation link" do
      it "redirect_to love_page_path" do
        get :show, id: invitation.id
        expect(response).to redirect_to(create_account_path)
      end

      after { expect(response.cookies['invitation_id']).to eq(invitation.id) }
    end

    context "invalid invitation link" do
      it "redirect_to love_page_path" do
        get :show, id: 404
        expect(response.status).to eq 404
      end

      after { expect(response.cookies['invitation_id']).to be nil }
    end
  end
end
