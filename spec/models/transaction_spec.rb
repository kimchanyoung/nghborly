require 'rails_helper'

describe Transaction do
  context "validations" do
    it { should validate_inclusion_of(:transaction_type).in_array(%w(request response fulfillment)) }
  end

  context "associations" do
    it { should belong_to :request }
  end
end
