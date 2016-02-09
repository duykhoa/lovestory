require 'spec_helper'

describe RecentPost do
  describe "#page" do
    let!(:posts) { create_list(:post, 26, love_page: love_page) }
    let(:love_page) { create(:love_page) }
    let(:recent_post) { RecentPost.new(love_page) }
    subject { recent_post.page.count }

    it do
      expect(recent_post.page(1).count).to eq 25
      expect(recent_post.page(2).count).to eq 1
    end
  end
end
