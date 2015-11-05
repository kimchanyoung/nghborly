require 'rails_helper'

describe Group do
  context "validations" do
    it { should validate_presence_of :primary_number }
    it { should validate_presence_of :street_name }
    it { should validate_presence_of :city_name }
    it { should validate_presence_of :state_abbreviation }
    it { should validate_presence_of :zipcode }
  end

  context "associations" do
    it { should have_many :users }
    it { should have_many :requests }
  end

  context "#name" do
    let(:group) { FactoryGirl.create :group }

    it "should returns its name based on its attributes" do
      expect(group.name).to eq("#{group.primary_number}  #{group.street_name} #{group.street_suffix}")
    end
  end

  context "#create" do
    let (:minimum_group_attributes) { FactoryGirl.attributes_for :group }

    it "should save if a value for street suffix is provided" do
      expect{
        attributes = minimum_group_attributes.merge({street_suffix: "Street"})
        Group.create(attributes)
      }.to change{Group.count}.by(1)
    end
  end
end
