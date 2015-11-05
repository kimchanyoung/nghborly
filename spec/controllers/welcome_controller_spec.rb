require 'rails_helper'

describe WelcomeController do
  let(:user) { FactoryGirl.create(:user) }

  context "user is not signed in" do
    describe "GET index" do
      it "should redirect the user to login_path" do
        get (:index)
        expect(response).to redirect_to(login_path)
      end
    end
  end

  context "user is signed in" do
    before(:each) do
      allow_any_instance_of(UserActionsController).to receive(:current_user).and_return(user)
    end

    describe "GET index" do
      it "should render the index template" do
        get (:index)
        expect(response).to render_template(:index)
      end
    end
  end
end
