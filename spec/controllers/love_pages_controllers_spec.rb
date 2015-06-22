require "rails_helper"

describe LovePagesController do
  describe "GET index" do
    let!(:user) { create(:user) }

    before do
      sign_in user
      get :index
    end

    it "renders index template" do
      expect(response.status).to eq 200
      expect(response).to render_template("index")
      expect(assigns(:love_pages)).to eq user.love_pages
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
        let!(:another_love_page) { create(:love_page, user: user) }

        it "log in and redirect to index action" do
          get :facebook

          expect(response).to redirect_to(love_pages_path)
        end
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
