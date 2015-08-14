require 'rails_helper'

describe ProcessLovePage do
  describe ".new" do
    let(:process_love_page) { ProcessLovePage.new(nil, nil, nil, {}) }
    it "returns new object" do
      expect(process_love_page).to be_a(ProcessLovePage)
    end
  end

  describe "#call" do
    context "user exist" do
      let(:user) { build(:user) }
      let(:process_love_page) { ProcessLovePage.new(user, nil, nil, {}) }

      it "call JoinPage and Invitations::Remove" do
        expect(JoinPage).to receive_message_chain(:new, :call)
        expect(Invitations::Remove).to receive_message_chain(:new, :call)
        process_love_page.call
      end
    end

    context "user doesn't exist" do
      let(:cookies) { {} }
      let(:invitation_id) { 999 }
      let(:process_love_page) { ProcessLovePage.new(nil, nil, invitation_id, cookies) }

      it "sets cookies" do
        process_love_page.call
        expect(JoinPage).to receive(:new).exactly(0).times
        expect(Invitations::Remove).to receive(:new).exactly(0).times

        expect(cookies.keys).to include("invitation_id")
        expect(cookies.fetch("invitation_id")).to eq(invitation_id)
      end
    end
  end
end
