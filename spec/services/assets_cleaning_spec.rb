require "rails_helper"

describe AssetsCleaning do
  describe ".call" do
    subject { Asset.count }

    context "assets is created <= 3 hours ago" do
      before do
        create(:asset, created_at: 181.minutes.ago)
        AssetsCleaning.()
      end

      it { is_expected.to eq 0 }
    end

    context "assets is created <= 6 hours ago" do
      before do
        create(:asset, created_at: 6.hours.ago)
        AssetsCleaning.()
      end

      it { is_expected.to eq 0 }
    end

    context "assets is created >= 2 hours ago" do
      before do
        create(:asset, created_at: 119.minutes.ago)
        AssetsCleaning.()
      end

      it { is_expected.to eq 1 }
    end

    context "assets post is not empty" do
      let(:post) { create(:post) }

      before do
        create(:asset, created_at: 4.hours.ago, post: post)
        AssetsCleaning.()
      end

      it { is_expected.to eq 1 }
    end
  end
end
