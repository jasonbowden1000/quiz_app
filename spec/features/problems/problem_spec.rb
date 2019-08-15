require "rails_helper"

RSpec.describe "Problems" do

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

  describe "when viewed" do
    context "out of order" do
      it "should redirect to the first untaken question" do
        login_as(user1)
        visit quizzes_path

        within("div#quiz_#{quiz1.id}") do
          click_button "Take Quiz"
        end

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
      end
    end
  end
end
