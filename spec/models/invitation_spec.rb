require 'rails_helper'

describe Invitation do
  it { should belong_to (:user) }
  it { should belong_to (:love_page) }

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

  describe ".remove_expired_link" do
    let!(:invitation_link) { create(:invitation) }
    let!(:expired_invitation_link) { create(:invitation, created_at: Invitation::EXPIRED_IN.ago) }

    before do
      expect(Invitation.count).to eq(1)
      expect(Invitation.unscoped.count).to eq(2)

      Invitation.remove_expired_link
    end

    it "removes expired_link" do
      expect(Invitation.count).to eq(1)
    end
  end
end
