require "rails_helper"

describe LovePagesController do
  describe "GET index" do
    let!(:user) { create(:user) }
    let!(:love_page) { create(:love_page, user: user) }

    before do
      sign_in user
    end

    it "renders index template" do
      get :index
      expect(response.status).to eq 200
      expect(response).to render_template("index")
    end

    it "renders index template" do
      get :index, format: :json
      expect(response.status).to eq 200
      expect(JSON.parse(response.body)['love_pages'].length).to eq 1
    end
  end

  describe "GET facebook" do
    before do
      allow(controller).to receive(:omniauth_params).and_return({
        uid: "123",
        email: "kevintran@lovestory.com",
        provider: "facebook"
      })
    end

    context "new account registered" do
      before { expect(User.count).to eq 0 }

      it "creates new account" do
        get :facebook
        user = User.first

        expect(response).to redirect_to(
          love_page_path(user.love_pages.first)
        )
      end
    end

    context "register account login" do
      let!(:user) { create(:user, uid: "123") }

      context "user has 1 love_page" do
        it "log in and redirects to this page" do
          get :facebook
          expect(response).to redirect_to(
            love_page_path(user.love_pages.first)
          )
        end
      end

      context "user has more than 1 love_page" do
        pending
      end
    end
  end

  describe "GET show" do
    let!(:user) { create(:user) }
    let!(:love_page) { create(:love_page, user: user) }
    let!(:posts) { create_list(:post, 5, love_page_id: user.love_pages.first.id) }

    before { sign_in user }

    it "redirects to show page" do
      get :show, id: user.love_pages.first.id
      expect(response.status).to eq 200
    end
  end
end
