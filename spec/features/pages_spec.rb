require "rails_helper"
include Warden::Test::Helpers

RSpec.describe "A user on the homepage" do
  let!(:user) { FactoryBot.create(:user) }

  describe "when logged in " do
    before do
      login_as(user)
      visit "/"
    end

    it "should see the dashboard" do
      expect(page).to have_content "Dashboard"
    end

    it "should be greeted by first and last name" do
      expect(page).to have_content "#{user.first_name} #{user.last_name}"
    end
  end

  describe "when not logged in" do
    before do
      logout
      visit "/"
    end

    it "should not see the dashboard" do
      expect(page).to_not have_content "Dashboard"
    end

    it "should not see their name on the page" do
      expect(page).to_not have_content "#{user.first_name} #{user.last_name}"
    end
  end
end
