require "rails_helper"

RSpec.describe "A logged in user on the homepage" do

  let(:user) { FactoryBot.create(:user) }

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

RSpec.describe "A guest (not logged in) user on the homepage" do

  let(:user) { FactoryBot.create(:user) }

  before do
    visit "/"
  end

  it "should not see the dashboard" do
    expect(page).to_not have_content "Dashboard"
  end

  it "should not see the sidebar" do
    expect(page).to_not have_content "Menu"
  end

  it "should not see their name on the page" do
    expect(page).to_not have_content "#{user.first_name} #{user.last_name}"
  end
end
