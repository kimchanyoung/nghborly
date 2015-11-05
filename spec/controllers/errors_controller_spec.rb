require 'rails_helper'

describe ErrorsController do
  describe "GET error404" do
    it "should render the error404 template" do
      get :error404
      expect(response).to render_template(:error404)
    end

    it "should have an HTTP status code of 404" do
      get :error404
      expect(response.status).to eq(404)
    end
  end

  describe "GET error500" do
    it "should render the error500 template" do
      get :error500
      expect(response).to render_template(:error500)
    end

    it "should have an HTTP status code of 500" do
      get :error500
      expect(response.status).to eq(500)
    end
  end
end
