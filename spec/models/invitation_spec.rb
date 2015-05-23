require 'rails_helper'

describe Invitation do
  it { should belong_to (:user) }

  describe ".find invitation by uuid" do
    subject { Invitation.find_by_id(id) }

    context "a invitation that exist" do
      let!(:invitation) { create(:invitation) }
      let(:id) { invitation.id }

      it "returns invitation" do
        is_expected.to eq invitation
      end
    end

    context "a invitation that doesn't exist" do
      let(:id) { 999 }
      it "returns invitation" do
        is_expected.to be nil
      end
    end

    context "a invitation that expired" do
      let!(:invitation) { create(:invitation, created_at: (Invitation::EXPIRED_IN + 1).day.ago) }
      let(:id) { invitation.id }

      it "returns invitation" do
        is_expected.to be nil
      end
    end
  end
end
