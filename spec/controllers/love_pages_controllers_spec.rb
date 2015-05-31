require "rails_helper"

describe LovePagesController do
  describe "GET facebook" do
    before do
      allow(controller).to receive(:omniauth_params).and_return({
        uid: "123",
        email: "kevintran@lovestory.com",
        provider: "facebook"
      })
    end

    context "new account registered" do
      it "create new account" do
        get :facebook
        expect(response).to redirect_to(love_page_path(User.first.love_pages.first.id))
      end
    end

    context "register account login" do
      let!(:user) { create(:user, uid: "123") }

      it "return the existed account" do
        get :facebook
        expect(response).to redirect_to(love_page_path(user.love_pages.first.id))
      end
    end
  end

  describe "GET show" do
    let!(:user) { create(:user) }
    let!(:posts) { create_list(:post, 5, love_page_id: user.love_pages.first.id) }

    before { sign_in user }

    it "redirects to show page" do
      get :show, id: user.love_pages.first.id
      expect(response.status).to eq 200
    end

    it "returns posts" do
      get :show, id: user.love_pages.first
      expect(assigns(:posts)).not_to be nil
      expect(assigns(:posts).count).to eq 5
    end
  end
end
