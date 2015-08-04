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
end
