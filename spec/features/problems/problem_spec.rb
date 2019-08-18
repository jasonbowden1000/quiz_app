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

  context "without a selection" do
    it "should notify the user" do
      click_button "Submit Answer"

      expect(page).to have_content "Please make a selection"
    end
  end

  describe "when viewed" do
    context "out of order" do
      it "should redirect to the first untaken question" do
        path_for_problem1 = current_path
        path_parts = current_path.split("/")
        path_parts.pop()
        path_for_problem3 = path_parts.push(3).join("/")
        visit path_for_problem3

        expect(page).to have_current_path(path_for_problem1)
      end
    end

    context "when the quiz is finished" do
      it "should redirect to the stats page" do
        path_for_problem1 = current_path

        quiz1.questions.length.times do
          choose("choice_2")
          click_button "Submit Answer"
        end

        stats_path = current_path

        visit path_for_problem1

        expect(page).to have_current_path(stats_path)
      end
    end
  end
end
