require "rails_helper"

RSpec.describe "Submitted Problems" do

  let!(:user1) { FactoryBot.create(:user) }
  let!(:quiz1) { FactoryBot.create(:quiz_with_decks, user: user1) }

  context "without a selection" do
    it "should notify the user" do
      login_as(user1)
      visit quizzes_path
      within("div#quiz_#{quiz1.id}") do
        click_button "Take Quiz"
      end

      click_button "Submit Answer"

      expect(page).to have_content "Please make a selection"
    end
  end
end
