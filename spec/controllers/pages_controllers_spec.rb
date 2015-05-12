require "rails_helper"

describe PagesController do

  describe "GET facebook" do
    before do
      allow(controller).to receive(:omniauth_params).and_return({
        uid: "123",
        email: "kevintran@lovestory.com",
        provider: "facebook"
      })
    end

    context "new account registered" do
      before { expect(Account.count).to eq 0 }

      it "create new account" do
        get :facebook
        expect(response.status).to eq 200
      end

      after { expect(Account.count).to eq 1 }
    end

    context "register account login" do
      let!(:user) { create(:user, uid: "123") }

      before { expect(Account.count).to eq 1 }

      it "return the existed account" do
        get :facebook
        expect(response.status).to eq 200
      end

      after { expect(Account.count).to eq 1 }
    end
  end
end