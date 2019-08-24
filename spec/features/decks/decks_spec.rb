require "rails_helper"

RSpec.describe 'Decks' do
  let(:user1) { FactoryBot.create(:user) }

  before do
    login_as(user1)
    visit "/"
    @deck_title = Faker::Lorem.unique.sentence(4)
    @deck_description = Faker::Lorem.unique.paragraph(4)
  end

  context "when created by users" do
    it "should send the user to the add question form" do
      click_link "Manage Decks"
      click_link "Add Deck"
      fill_in "Title", with: @deck_title
      fill_in "Description", with: @deck_description
      click_button "Create Deck"


      expect(page.first("h2").text).to eql("Add Question")
      expect(page.first("h4")).to have_content(@deck_title)
    end
  end 

  context "created by other users" do
    let!(:user2) { FactoryBot.create(:user, first_name: "Tony", last_name: "Stark", email: "ironman456@gmail.com" )}
    let!(:deck1) { FactoryBot.create(:deck, id: 123, title: "My Armors", description: "Don't leave home without them", user: user2 )}
    let!(:deck2) { FactoryBot.create(:deck, id: 456, title: "Rogues Gallery", description: "baddies", user: user2 )}

    it "should not visible to the current user" do
      visit decks_path
      expect(page).not_to have_content deck1.title
      expect(page).not_to have_content deck2.title
    end
  end
end