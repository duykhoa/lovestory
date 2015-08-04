require "spec_helper"
require "cancan/matchers"

describe Ability do
  subject { Ability.new(user) }

  context "normal user" do
    let(:user) { create(:user) }

    context "can ru user page" do
      let(:page) { create(:love_page, user: user) }

      it { should be_able_to(:ru, page) }
    end

    context "cannot ru user page" do
      let(:another_user) { create(:user) }
      let(:page) { create(:love_page, user: another_user) }

      it { should_not be_able_to(:ru, page) }
    end

    context "can create page" do
      it { should be_able_to(:create, LovePage) }
    end

    context "can manage any post than in any page that belongs to this user" do
      let(:page) { create(:love_page, user: user) }
      let!(:post) { create(:post, love_page: page, user: user) }

      it { should be_able_to(:manage, post) }
    end

    context "cannot manage a post that not belongs to this user" do
      let(:another_user) { create(:user) }
      let(:page) { create(:love_page, user: another_user) }
      let!(:post) { create(:post, love_page: page, user: another_user) }

      it { should_not be_able_to(:manage, post) }
    end

    context "can read a post that authored by partner" do
      let(:page) { create(:love_page, user: user) }

      let(:another_user) { create(:user) }
      let!(:post) { create(:post, love_page: page, user: user) }

      before { create(:user_love_page, user: another_user, love_page: page) }
      subject { Ability.new(another_user) }

      it { should be_able_to(:read, post) }
    end
  end
end
