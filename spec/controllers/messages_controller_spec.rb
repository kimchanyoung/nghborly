require 'rails_helper'

describe MessagesController do
  before(:each) do
    @request_obj = FactoryGirl.create(:request)
  end

  context "user is not signed in" do
    describe "GET #index" do
      it "should redirect to login path" do
        get :index, request_id: @request_obj.id
        expect(response).to redirect_to login_path
      end
    end

    describe "POST #create" do
      it "should redirect to login path" do
        get :index, request_id: @request_obj.id
        expect(response).to redirect_to login_path
      end
    end
  end

  context "user is signed in as a party to the message" do
    before(:each) do
      @user = FactoryGirl.create(:user)
      @request_obj = FactoryGirl.create(:request_with_neighbor, requester: @user)
      allow_any_instance_of(UserActionsController).to receive(:current_user).and_return(@user)

      3.times do
        FactoryGirl.create(:message, request: @request_obj, sender: @user)
      end
    end

    describe "GET #index" do
      it "should assign all messages for this request" do
        get :index, request_id: @request_obj.id
        expect(assigns(:messages)).to match_array(@request_obj.messages)
      end

      it "should create a new message object" do
        get :index, request_id: @request_obj.id
        expect(assigns(:message)).to be_a_new(Message)
      end
    end

    describe "POST #create" do
      context "valid message" do
        it "should add a message to this particular request" do
          expect{
            post :create, { request_id: @request_obj.id, message: { content: "Test Messsage" } }
          }.to change{@request_obj.messages.count}.by(1)
        end

        it "should redirect back to the messages page" do
          post :create, { request_id: @request_obj.id, message: { content: "Test Messsage" } }
          expect(response).to redirect_to(request_messages_path(@request_obj, anchor: 'bottom'))
        end
      end

      context "invalid message" do
        it "should set a flash error" do
          post :create, { request_id: @request_obj.id, message: { content: '' } }
          expect(flash[:alert]).not_to be_nil
        end

        it "should set a flash error" do
          post :create, { request_id: @request_obj.id, message: { content: '' } }
          expect(response).to redirect_to(request_messages_path(@request_obj, anchor: 'bottom'))
        end
      end
    end
  end

  context "user is signed in but is not a party to the message" do
    before(:each) do
      @user = FactoryGirl.create(:user)
      @request_obj = FactoryGirl.create(:request)
      allow_any_instance_of(UserActionsController).to receive(:current_user).and_return(@user)
    end

    describe "GET #index" do
      it "should redirect user" do
        get :index, request_id: @request_obj.id
        expect(response).to redirect_to(request_path(@request_obj))
      end
    end

    describe "POST #create" do
      it "should redirect user" do
        post :create, request_id: @request_obj.id
        expect(response).to redirect_to(request_path(@request_obj))
      end
    end
  end

  context "user is signed in, is a party to the request, but the request is inactive" do
    before(:each) do
      @user = FactoryGirl.create(:user)
      @request_obj = FactoryGirl.create(:request, requester: @user, created_at: 1.week.ago)
      allow_any_instance_of(UserActionsController).to receive(:current_user).and_return(@user)
    end

    describe "POST #create" do
      it "should set a flash error" do
        post :create, request_id: @request_obj.id
        expect(flash[:alert]).to be_present
      end

      it "should redirect to the request messages" do
        post :create, request_id: @request_obj.id
        expect(response).to redirect_to(request_messages_path(@request_obj))
      end
    end
  end
end
