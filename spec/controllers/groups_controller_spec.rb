require 'rails_helper'

describe GroupsController do
  let(:user) { FactoryGirl.create(:user) }

  before(:each) do
    allow_any_instance_of(GroupsController).to receive(:current_user).and_return(user)
  end

  describe "GET inquire" do
    it "should render the inquire template" do
      get (:inquire)
      expect(response).to render_template(:inquire)
    end
  end

  describe "GET reassign" do
    it "should update the user's group to nil" do
      get :reassign
      expect(user.group_id).to be_nil
    end

    it "should redirect to groups_assign_path" do
      get :reassign
      expect(response).to redirect_to(groups_assign_path)
    end
  end

  describe "POST assign" do
    let(:group) { FactoryGirl.create(:group) }

    before(:each) { user.group_id = nil }


    context "valid address provided by user" do
      before(:each) do
        allow_any_instance_of(GroupsController).to receive(:find_group_id).and_return(group.id)
      end

      it "should assign the user to a group" do
        post :assign, { address: "123 Main Street" }
        expect(user.group_id).to eq(group.id)
      end

      it "should set a flash[:success] message" do
        post :assign, { address: "123 Main Street" }
        expect(flash[:success]).to eq("Welcome to #{group.name}")
      end

      it "should redirect to root_path" do
        post :assign, { address: "123 Main Street" }
        expect(response).to redirect_to(root_path)
      end
    end

    context "invalid address provided by user" do
      before(:each) do
        allow_any_instance_of(GroupsController).to receive(:find_group_id).and_return(nil)
      end

      it "should set a flash[:now] message" do
        post :assign, { address: "123 Main Street" }
        expect(flash[:now]).to eq("We couldn't find your building. Can you be more specific?")
      end
    end
  end
end
