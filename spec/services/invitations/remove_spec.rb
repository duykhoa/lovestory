require "rails_helper"

describe Invitations::Remove do
  describe ".new" do
    subject { Invitations::Remove.new(123, {}) }

    it "returns new object" do
      is_expected.to be_a(Invitations::Remove)
    end
  end

  describe "#call" do
    let(:cookies_name) { Invitations::Remove::COOKIES_NAME }
    context "invitation exist" do
      let!(:invitation) { create(:invitation) }
      let!(:cookies) { { cookies_name => invitation.id } }
      let(:remove_invitation) { Invitations::Remove.new(invitation.id, cookies) }

      before do
        expect(Invitation.count).to eq 1
        expect(cookies[cookies_name]).to eq invitation.id

        remove_invitation.call
      end

      it "destroy invitation" do
        expect(Invitation.count).to eq 0
      end

      it "remove cookies" do
        expect(cookies['invitation_id']).to be nil
      end
    end

    context "invitation does not exist" do
      let(:remove_invitation) { Invitations::Remove.new(123, {}) }

      it "destroy invitation" do
        expect { remove_invitation.call }.not_to raise_error
      end
    end
  end
end
