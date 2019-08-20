require "rails_helper"

RSpec.describe "Attempts" do

  let!(:user1) { FactoryBot.create(:user) }
  let!(:user2) { FactoryBot.create(:user) }
  let!(:quiz1) { FactoryBot.create(:quiz_with_empty_decks, user: user1) }
  let!(:quiz2) { FactoryBot.create(:quiz, user: user2) }

  describe "can't be started by users" do
    it "with quizzes without decks" do 
      login_as(user2)
      visit quizzes_path

      within("div#quiz_#{quiz2.id}") do
        expect(page).not_to have_button "Take Quiz"
        expect(page).to have_content "This quiz has no decks."
        expect(page).to have_link "Add a deck!"
      end
   end

    it "when all decks of a quiz are empty" do
      login_as(user1)
      visit quizzes_path

      within("div#quiz_#{quiz1.id}") do
        expect(page).not_to have_button "Take Quiz"
        expect(page).to have_link "Manage Decks"
      end
    end
  end
end
