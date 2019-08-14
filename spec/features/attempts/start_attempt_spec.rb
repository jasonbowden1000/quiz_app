require "rails_helper"

RSpec.describe "Attempts" do

  let!(:user1) { FactoryBot.create(:user) }
  let!(:user2) { FactoryBot.create(:user) }
  let!(:user3) { FactoryBot.create(:user) }
  let!(:quiz1) { FactoryBot.create(:quiz_with_decks, user: user1) }
  let!(:quiz2) { FactoryBot.create(:quiz_with_empty_decks, user: user2) }
  let!(:quiz3) { FactoryBot.create(:quiz, user: user3) }

  describe "can be started by users" do
    it "by clicking the Take test button" do
      login_as(user1)
      visit quizzes_path
      within("div#quiz_#{quiz1.id}") do
        click_button "Take Quiz"
      end

      # expect page to hvae some stuff
    end
  end

  describe "can't be started by users" do
    it "with quizzes without decks" 

    it "when all decks of a quiz are empty" do
      login_as(user2)
      visit quizzes_path
      Rails.logger.info quizzes_path

      within("div#quiz_#{quiz2.id}") do
        expect(page).not_to have_button "Take Quiz"
        expect(page).to have_link "Manage Decks"
      end
    end
  end
end