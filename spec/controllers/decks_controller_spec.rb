require "rails_helper"

RSpec.describe DecksController, type: :controller do
  describe "GET index" do
    it "should redirect guests to the home page" do
      get :index
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end