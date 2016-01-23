require 'rails_helper'

describe Post do
  it { should belong_to(:love_page) }
  it { should belong_to(:user) }
  it { should have_many(:assets) }

  describe "order descreasing" do
    let(:post) { create(:post)  }
    let(:post_1_day_ago) { create(:post, created_at: 1.day.ago)  }
    subject { Post.all }

    it "returns the latest post first" do
      expect(subject.index(post_1_day_ago)).to eq 0
    end
  end

  describe "soft_delete" do
    let!(:post) { create(:post) }

    before do
      expect(post.deleted_at).to be nil
      expect(Post.count).to eq 1
    end

    it "set deleted_at" do
      post.soft_delete!
      post.reload

      expect(post.deleted_at).not_to be nil
      expect(post.deleted?).to be true
      expect(Post.count).to eq 0
    end
  end
end
