require 'rails_helper'

describe Request do
  context "validations" do
    it { should validate_presence_of :content }
    it { should validate_presence_of :requester }
    it { should validate_presence_of :group }
    it { should allow_value(true).for :is_fulfilled }
    it { should allow_value(false).for :is_fulfilled }
  end

  context "associations" do
    it { should have_many :messages }
    it { should have_many :transactions }
    it { should have_many :votes }
    it { should belong_to :requester }
    it { should belong_to :responder }
    it { should belong_to :group }
  end

  context "#active?" do
    context "has no responder" do
      it "should be active if created right now" do
        expect(FactoryGirl.create(:request).active?).to be true
      end

      it "should not be active if created more than 45 minutes ago" do
        expect(FactoryGirl.create(:request, created_at: 1.hour.ago).active?).to be false
      end
    end

    context "has a responder" do
      let(:request) do
        request = FactoryGirl.create(:request_with_neighbor)
        request.is_fulfilled = true
        request
      end

      it "should be not be active if it is fulfilled" do
        expect(request.active?).to be false
      end

      it "should not be active it was created more than 45 minutes ago" do
        expect(request.active?).to be false
      end
    end
  end

  context "#is_party_to?" do
    let(:request) { FactoryGirl.create(:request_with_neighbor) }
    let(:user)    { FactoryGirl.create(:user)}

    it "should return false when the argument is not a party to the request" do
      expect(request.is_party_to?(user)).to be false
    end

    it "should return true when the argument is a party to the request" do
      request = FactoryGirl.create(:request_with_neighbor, requester_id: user.id)
      expect(request.is_party_to?(user)).to be true
    end
  end

  context "#can_view?" do
    let(:user)   { FactoryGirl.create(:user) }

    context "request has no neighbor" do
      let(:request) { FactoryGirl.create(:request) }

      it "should return false if the user is not part of the group" do
        expect(request.can_view?(user)).to be false
      end

      it "should return true if the user is part of the group" do
        user
        request = FactoryGirl.create(:request, group_id: user.group.id)
        expect(request.can_view?(user)).to be true
      end
    end

    context "request has a neighbor" do
      let(:request) { FactoryGirl.create(:request_with_neighbor) }

      it "should return false if the user is not responder or requester" do
        expect(request.can_view?(user)).to be false
      end

      it "should return true if the user is responder or requester" do
        request = FactoryGirl.create(:request_with_neighbor, requester_id: user.id)
        expect(request.can_view?(user)).to be true
      end
    end
  end
end
