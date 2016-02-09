require 'spec_helper'

describe RecentPost do
  describe "#page" do
    let(:love_page) { create(:love_page) }
    let(:recent_post) { RecentPost.new(love_page) }
    subject { recent_post.page }

    it do
      is_expected.to be_a(Array)
    end
  end
end
