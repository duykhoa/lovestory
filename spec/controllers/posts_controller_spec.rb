require "rails_helper"

describe PostsController do
  let!(:user) { create(:user) }
  let!(:page) { create(:love_page, user: user) }

  describe "GET undelete" do
    let!(:post) { create(:post, user: user, love_page: page )}
    before do
      sign_in(user)
      post.soft_delete!
      get :undelete, id: post.id
    end

    it "render success status" do
      expect(response.status).to eq 200
    end
  end
end
