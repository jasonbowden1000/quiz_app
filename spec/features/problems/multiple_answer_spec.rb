require "rails_helper"

RSpec.describe "Multiple Answer Problems" do

  let!(:user1) { FactoryBot.create(:user) }
  let!(:quiz1) { FactoryBot.create(:multiple_answer_quiz, decks_count: 1, user: user1) }

  context "when a quiz is finished" do
    it "should be scored accurately" do
      login_as(user1)
      visit quizzes_path
      within("div#quiz_#{quiz1.id}") do
        click_button "Take Quiz"
      end

      attempt_id = current_path.split("/")[2]
      correct_choice1 = "choice_1" 
      correct_choice2 = "choice_3" 
      wrong_choice = "choice_4"

      check(correct_choice1)
      check(correct_choice2)
      click_button "Submit Answer"

      check(wrong_choice)
      click_button "Submit Answer"

      check(correct_choice1)
      click_button "Submit Answer"

      check(correct_choice1)
      check(wrong_choice)
      click_button "Submit Answer"

      within("tr#attempt_#{attempt_id}") do
        expect(page).to have_content "1/4"
        expect(page).to have_content "25%"
      end
    end
  end
end
