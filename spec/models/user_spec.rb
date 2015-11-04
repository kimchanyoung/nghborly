require 'rails_helper'

describe User do
  context "validations" do
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :last_name }
    it { should validate_presence_of :email }
  end

  context "associations" do
    it { should belong_to :group }
    it { should have_many :made_requests }
    it { should have_many :fulfilled_requests }
    it { should have_many :votes }
  end

  context "#requests_in_last_24_hours" do
    let(:user) { FactoryGirl.create :user }

    it "should return the number of requests made in the last 24 hours" do
      user

      2.times do |_|
        FactoryGirl.create(:request, requester_id: user.id)
      end

      expect(user.requests_in_last_24_hours).to eq(2)
    end

    it "should not count requests made more than 24 hours in the past" do
      user

      2.times do |_|
        FactoryGirl.create(:request, requester_id: user.id)
      end

      FactoryGirl.create(:request, requester_id: user.id, created_at: 2.days.ago)

      expect(user.requests_in_last_24_hours).to eq(2)
    end
  end
end
