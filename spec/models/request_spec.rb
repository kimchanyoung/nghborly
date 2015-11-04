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
end
