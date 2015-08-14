require "rails_helper"

describe InvitationsController do
  let!(:user) { create(:user) }
  let!(:page) { create(:love_page, user: user) }
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
      context "non signin user" do
        it "redirect_to love_page_path" do
          get :show, id: invitation.id
          expect(response).to redirect_to(root_path + "#signup-modal")
        end

        after { expect(response.cookies['invitation_id']).to eq(invitation.id) }
      end

      context "signin user" do
        let(:another_user) { create(:user) }

        before { sign_in another_user }

        it "redirect_to love_page_path" do
          expect(another_user.love_pages.count).to eq 0

          get :show, id: invitation.id
          expect(response).to redirect_to(root_path)
        end

        after do
          expect(response.cookies['invitation_id']).to be_nil
          expect(another_user.love_pages.count).to eq 1
          expect(Invitation.count).to eq 0
        end
      end
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
