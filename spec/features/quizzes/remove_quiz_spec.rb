require "rails_helper"

RSpec.describe "Quizzes" do
  let!(:user1) { FactoryBot.create(:user_with_quizzes, quizzes_count: 3 )}

  context "when deleted" do
    it "should no longer be visible on a user's quizzes page", js: true do
      login_as(user1)
      visit quizzes_path
      quizzes = page.all("div.quiz");
      within quizzes.first do
        page.accept_confirm do
          click_link "Delete"
        end
      end

      expect(quizzes.length).not_to eql(page.all("div.quiz").length)
    end

    it "should not impact existing quiz attempts", js: true do
      login_as(user1)
      visit quizzes_path
      quiz = first("div.quiz")
      title = quiz.first('p.card-header-title').text
      within quiz do
        click_button "Take Quiz"
      end

      attempt_id = current_path.split("/")[2]
      choose("choice_1")
      click_button "Submit Answer"

      visit quizzes_path

      quiz = first("div.quiz")
      title = quiz.first('p.card-header-title').text
      within quiz do
        page.accept_confirm do
          click_link "Delete"
        end
      end

      visit stats_path
      click_link title
      expect(page.current_path).to eql(attempt_problem_path(attempt_id, 2))
    end
  end
end