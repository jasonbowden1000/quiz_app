require "rails_helper"

RSpec.describe 'Decks' do
  let(:user1) { FactoryBot.create(:user) }
  # let!(:user2) { FactoryBot.create(:user, first_name: "Tony", last_name: "Stark", email: "ironman123@gmail.com") }
  let(:deck1) { FactoryBot.create(:deck, user: user1 )}

  before do
    login_as(user1)
    visit "/"
  end

  context "created by users" do
    it "should be visible on a user's decks page" do
      click_link "Manage Decks"
      click_link "Add Deck"
      fill_in "Title", with: deck1.title
      fill_in "Description", with: deck1.description
      click_button "Create Deck"
      click_link "All Decks"

      expect(page.first("h2").text).to eql("Your Decks")
      expect(page).to have_content deck1.title
      expect(page).to have_content deck1.description
    end
  end 
end