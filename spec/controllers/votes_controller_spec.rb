require 'rails_helper'

describe VotesController do
  before(:each) do
    @user = FactoryGirl.create(:user)
    @request_obj = FactoryGirl.create(:request_with_neighbor, requester: @user)
  end

  context "user is not logged in" do
    it "should redirect to login_path" do
      post :create, request_id: @request_obj.id
      expect(response).to redirect_to(login_path)
    end
  end

  context "user is logged in and is a party to the request" do
    before(:each) do
      allow_any_instance_of(UserActionsController).to receive(:current_user).and_return(@user)
    end

    context "the user can vote" do
      it "should create one new vote" do
        expect{
          post :create, { request_id: @request_obj.id, vote: { value: "1" } }
        }.to change{Vote.count}.by(1)
      end

      it "should set a flash[:success] message" do
        post :create, { request_id: @request_obj.id, vote: { value: "1" } }
        expect(flash[:success]).to be_present
      end

      it "should redirect to root_path" do
        post :create, { request_id: @request_obj.id, vote: { value: "1" } }
        expect(response).to redirect_to(root_path)
      end
    end

    context "user has already voted" do
      it "should not change the number of votes in the database" do
        FactoryGirl.create(:vote, request: @request_obj, candidate: @request_obj.responder)

          expect{
            post :create, { request_id: @request_obj.id, vote: { value: "1" } }
          }.to change{Vote.count}.by(0)
      end
    end

    context "current user is the responder" do
      it "should change the number of votes in the database by one" do
        allow_any_instance_of(UserActionsController).to receive(:current_user).and_return(@request_obj.responder)

        expect{
          post :create, { request_id: @request_obj.id, vote: { value: "1" } }
        }.to change{Vote.count}.by(1)
      end
    end
  end
end
