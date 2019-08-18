require "rails_helper"

RSpec.describe "Problems" do

  let!(:user1) { FactoryBot.create(:user) }
  let!(:quiz1) { FactoryBot.create(:quiz_with_decks, decks_count: 1, user: user1) }

  before do
    login_as(user1)
    visit quizzes_path
    within("div#quiz_#{quiz1.id}") do
      click_button "Take Quiz"
    end
  end

  context "when the quiz is finished" do
    it "multiple-choice problems should be scored accurately" do
      attempt_id = current_path.split("/")[2]
      correct_choice = "choice_1"
      wrong_choice = "choice_4"

      2.times { choose(correct_choice); click_button "Submit Answer"; }
      2.times { choose(wrong_choice); click_button "Submit Answer"; }

      within("tr#attempt_#{attempt_id}") do
        expect(page).to have_content "2/4"
        expect(page).to have_content "50%"
      end
    end
  end
end
